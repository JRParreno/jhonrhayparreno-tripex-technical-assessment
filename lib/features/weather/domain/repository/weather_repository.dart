import 'package:fpdart/fpdart.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/failure.dart';
import 'package:weather/weather.dart';

abstract interface class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather({
    required double longitude,
    required double latitude,
  });
  Future<Either<Failure, List<Weather>>> getWeatherForFiveDays({
    required double longitude,
    required double latitude,
  });
}
