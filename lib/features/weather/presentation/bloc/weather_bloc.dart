import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/failure.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/location/get_current_location.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/permission/app_permission.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/domain/usecase/index.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather _getCurrentWeather;
  final GetWeatherForFiveDays _getWeatherForFiveDays;
  final PermissionService _permissionService;
  final LocationService _locationService;

  WeatherBloc({
    required GetCurrentWeather getCurrentWeather,
    required GetWeatherForFiveDays getWeatherForFiveDays,
    required PermissionService permissionService,
    required LocationService locationService,
  })  : _getCurrentWeather = getCurrentWeather,
        _getWeatherForFiveDays = getWeatherForFiveDays,
        _permissionService = permissionService,
        _locationService = locationService,
        super(WeatherInitial()) {
    on<GetWeatherEvent>(onGetWeatherEvent);
  }

  Future<void> onGetWeatherEvent(
      GetWeatherEvent event, Emitter<WeatherState> emit) async {
    try {
      final locationPermGranted = await _permissionService.locationPermission();

      if (locationPermGranted) {
        emit(WeatherLoading());

        final userCurrentLocation = await _locationService.getCurrentPosition();

        final longitude = userCurrentLocation.longitude;
        final latitude = userCurrentLocation.latitude;

        final currentWeatherResponse = _getCurrentWeather.call(
          GetCurrentWeatherParams(longitude: longitude, latitude: latitude),
        );

        final weatherForFiveDaysResponse = _getWeatherForFiveDays.call(
          GetWeatherForFiveDaysParams(
            longitude: longitude,
            latitude: latitude,
          ),
        );

        final results = await Future.wait([
          currentWeatherResponse,
          weatherForFiveDaysResponse,
        ]);

        final currentWeatherResult = results[0] as Either<Failure, Weather>;
        final weatherForFiveDaysResult =
            results[1] as Either<Failure, List<Weather>>;

        if (currentWeatherResult.isLeft() &&
            weatherForFiveDaysResult.isLeft()) {
          return emit(
            const WeatherFailure(
              'Something went wrong please try again',
            ),
          );
        } else {
          final currentWeather = currentWeatherResult.fold(
            (failure) =>
                throw Exception('Failed to get current weather: $failure'),
            (weather) => weather,
          );

          final fiveDaysWeather = weatherForFiveDaysResult.fold(
            (failure) => throw Exception(
                'Failed to get weather for five days: $failure'),
            (weatherList) => weatherList,
          );

          return emit(
            WeatherSuccess(
              currentWeather: currentWeather,
              fiveDaysWeather: getDayInterval(fiveDaysWeather),
            ),
          );
        }
      }

      emit(const WeatherLocationDisable('Location not enable.'));
    } catch (e) {
      emit(const WeatherFailure('something went wrong'));
    }
  }

  List<Weather> getDayInterval(List<Weather> forecast) {
    final items = [0, 8, 16, 24, 32];

    return items.map((e) => forecast[e]).toList();
  }
}
