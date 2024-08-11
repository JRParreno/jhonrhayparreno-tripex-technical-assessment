import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/failure.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/location/get_current_location.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/permission/app_permission.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/domain/usecase/index.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/weather.dart';

import 'weather_bloc_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<LocationService>(),
    MockSpec<PermissionService>(),
    MockSpec<Weather>(),
    MockSpec<GetCurrentWeather>(),
    MockSpec<GetWeatherForFiveDays>(),
  ],
)
void main() {
  late MockLocationService mockLocationService;
  late MockPermissionService mockPermissionService;
  late WeatherBloc weatherBloc;
  late MockGetCurrentWeather mockGetCurrentWeather;
  late MockGetWeatherForFiveDays miockGetWeatherForFiveDays;
  late MockWeather mockWeather;
  late List<MockWeather> mockWeatherList;

  setUp(() {
    mockLocationService = MockLocationService();
    mockPermissionService = MockPermissionService();
    mockWeather = MockWeather();
    mockGetCurrentWeather = MockGetCurrentWeather();
    miockGetWeatherForFiveDays = MockGetWeatherForFiveDays();
    weatherBloc = WeatherBloc(
      locationService: mockLocationService,
      permissionService: mockPermissionService,
      getCurrentWeather: mockGetCurrentWeather,
      getWeatherForFiveDays: miockGetWeatherForFiveDays,
    );
    mockWeatherList = List.generate(
      40,
      (index) => mockWeather,
    );
    provideDummy<Either<Failure, List<Weather>>>(
      Right(
        [mockWeather],
      ),
    );
    provideDummy<Either<Failure, List<Weather>>>(
      Left(
        Failure(),
      ),
    );

    provideDummy<Either<Failure, Weather>>(
      Right(
        mockWeather,
      ),
    );
    provideDummy<Either<Failure, Weather>>(
      Left(
        Failure(),
      ),
    );
  });

  tearDown(() => weatherBloc.close());

  final Position mockPosition = Position(
    longitude: 12.120,
    latitude: 8.120,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    altitudeAccuracy: 0,
    heading: 0,
    headingAccuracy: 0,
    speed: 0,
    speedAccuracy: 0,
  );

  group(WeatherBloc, () {
    group('onGetWeatherEvent', () {
      test('GetWeatherEvent event props', () {
        // Assert
        final event = GetWeatherEvent();

        // Act
        weatherBloc.add(event);

        final List<Object?> expectedProps = [];

        // Assert
        expect(event.props, expectedProps);
      });

      blocTest(
        'emits [WeatherLoading, WeatherSuccess] when GetCurrentWeather is successful',
        build: () {
          // when permission is granted
          when(mockPermissionService.locationPermission())
              .thenAnswer((_) async => true);
          // when getting the current location
          when(mockLocationService.getCurrentPosition())
              .thenAnswer((_) async => mockPosition);

          when(mockGetCurrentWeather.call(any))
              .thenAnswer((_) async => Right(mockWeather));

          when(miockGetWeatherForFiveDays.call(any))
              .thenAnswer((_) async => Right(mockWeatherList));

          return weatherBloc;
        },
        act: (bloc) => bloc.add(GetWeatherEvent()),
        expect: () => <WeatherState>[
          WeatherLoading(),
          WeatherSuccess(
            currentWeather: mockWeather,
            fiveDaysWeather: weatherBloc.getDayInterval(mockWeatherList),
          ),
        ],
      );

      blocTest(
        'emits [WeatherLoading, WeatherFailure] when GetCurrentWeather is all values is isLeft',
        build: () {
          // when permission is granted
          when(mockPermissionService.locationPermission())
              .thenAnswer((_) async => true);
          // when getting the current location
          when(mockLocationService.getCurrentPosition())
              .thenAnswer((_) async => mockPosition);

          when(mockGetCurrentWeather.call(any))
              .thenAnswer((_) async => Left(Failure()));

          when(miockGetWeatherForFiveDays.call(any))
              .thenAnswer((_) async => Left(Failure()));

          return weatherBloc;
        },
        act: (bloc) => bloc.add(GetWeatherEvent()),
        expect: () => <WeatherState>[
          WeatherLoading(),
          const WeatherFailure('Something went wrong please try again'),
        ],
      );

      blocTest(
        'emits [WeatherLoading, WeatherLocationDisable] when GetCurrentWeather is location disable',
        build: () {
          // when permission is not granted
          when(mockPermissionService.locationPermission())
              .thenAnswer((_) async => false);

          return weatherBloc;
        },
        act: (bloc) => bloc.add(GetWeatherEvent()),
        expect: () => <WeatherState>[
          const WeatherLocationDisable('Location not enable.'),
        ],
      );

      blocTest(
        'emits [WeatherLoading, WeatherFailure] when GetCurrentWeather is fiveDaysWeather throws an Exception',
        build: () {
          // when permission is granted
          when(mockPermissionService.locationPermission())
              .thenAnswer((_) async => true);
          // when getting the current location
          when(mockLocationService.getCurrentPosition())
              .thenAnswer((_) async => mockPosition);

          when(mockGetCurrentWeather.call(any))
              .thenAnswer((_) async => Right(mockWeather));

          when(miockGetWeatherForFiveDays.call(any))
              .thenAnswer((_) async => Left(Failure()));

          return weatherBloc;
        },
        act: (bloc) => bloc.add(GetWeatherEvent()),
        expect: () => <WeatherState>[
          WeatherLoading(),
          const WeatherFailure('something went wrong'),
        ],
      );

      blocTest(
        'emits [WeatherLoading, WeatherFailure] when GetCurrentWeatheris currentWeather throws an Exception',
        build: () {
          // when permission is granted
          when(mockPermissionService.locationPermission())
              .thenAnswer((_) async => true);
          // when getting the current location
          when(mockLocationService.getCurrentPosition())
              .thenAnswer((_) async => mockPosition);

          when(mockGetCurrentWeather.call(any))
              .thenAnswer((_) async => Left(Failure()));

          when(miockGetWeatherForFiveDays.call(any))
              .thenAnswer((_) async => Right(mockWeatherList));

          return weatherBloc;
        },
        act: (bloc) => bloc.add(GetWeatherEvent()),
        expect: () => <WeatherState>[
          WeatherLoading(),
          const WeatherFailure('something went wrong'),
        ],
      );
    });
  });
}
