import 'package:fpdart/fpdart.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/failure.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/usecase/usecase.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/domain/repository/weather_repository.dart';
import 'package:weather/weather.dart';

class GetCurrentWeather implements UseCase<Weather, GetCurrentWeatherParams> {
  final WeatherRepository weatherRepository;

  const GetCurrentWeather(this.weatherRepository);

  @override
  Future<Either<Failure, Weather>> call(GetCurrentWeatherParams params) async {
    return weatherRepository.getCurrentWeather(
      longitude: params.longitude,
      latitude: params.latitude,
    );
  }
}

class GetCurrentWeatherParams {
  final double longitude;
  final double latitude;

  GetCurrentWeatherParams({
    required this.longitude,
    required this.latitude,
  });
}
