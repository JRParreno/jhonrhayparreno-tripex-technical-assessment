import 'package:jhon_rhay_parreno_technical_assessment/core/error/exceptions.dart';
import 'package:weather/weather.dart';

abstract interface class WeatherRemoteDataSource {
  Future<Weather> getCurrentWeather({
    required double longitude,
    required double latitude,
  });
  Future<List<Weather>> getWeatherForFiveDays({
    required double longitude,
    required double latitude,
  });
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final WeatherFactory weatherFactory;

  const WeatherRemoteDataSourceImpl(this.weatherFactory);

  @override
  Future<Weather> getCurrentWeather({
    required double longitude,
    required double latitude,
  }) async {
    try {
      final response = await weatherFactory.currentWeatherByLocation(
        latitude,
        longitude,
      );
      return response;
    } catch (e) {
      throw ServerException('An error occurred during getting weather');
    }
  }

  @override
  Future<List<Weather>> getWeatherForFiveDays({
    required double longitude,
    required double latitude,
  }) async {
    try {
      final response = await weatherFactory.fiveDayForecastByLocation(
        latitude,
        longitude,
      );
      return response;
    } catch (e) {
      throw ServerException('An error occurred during getting weather');
    }
  }
}
