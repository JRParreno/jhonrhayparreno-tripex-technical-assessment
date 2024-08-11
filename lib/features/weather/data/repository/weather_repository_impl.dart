import 'package:fpdart/fpdart.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/exceptions.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/failure.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/domain/repository/weather_repository.dart';
import 'package:weather/weather.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  const WeatherRepositoryImpl(this.weatherRemoteDataSource);

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(
      {required double longitude, required double latitude}) async {
    try {
      final response = await weatherRemoteDataSource.getCurrentWeather(
        latitude: latitude,
        longitude: longitude,
      );
      return right(response);
    } on ServerException catch (e) {
      return left(ServerException(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Weather>>> getWeatherForFiveDays(
      {required double longitude, required double latitude}) async {
    try {
      final response = await weatherRemoteDataSource.getWeatherForFiveDays(
        latitude: latitude,
        longitude: longitude,
      );
      return right(response);
    } on ServerException catch (e) {
      return left(ServerException(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
