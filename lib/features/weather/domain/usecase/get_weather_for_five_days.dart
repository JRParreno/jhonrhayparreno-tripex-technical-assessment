import 'package:fpdart/fpdart.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/failure.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/usecase/usecase.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/domain/repository/weather_repository.dart';
import 'package:weather/weather.dart';

class GetWeatherForFiveDays
    implements UseCase<List<Weather>, GetWeatherForFiveDaysParams> {
  final WeatherRepository weatherRepository;

  const GetWeatherForFiveDays(this.weatherRepository);

  @override
  Future<Either<Failure, List<Weather>>> call(
      GetWeatherForFiveDaysParams params) async {
    return weatherRepository.getWeatherForFiveDays(
      longitude: params.longitude,
      latitude: params.latitude,
    );
  }
}

class GetWeatherForFiveDaysParams {
  final double longitude;
  final double latitude;

  GetWeatherForFiveDaysParams({
    required this.longitude,
    required this.latitude,
  });
}
