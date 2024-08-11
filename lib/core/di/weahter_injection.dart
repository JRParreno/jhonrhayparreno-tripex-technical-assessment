// coverage:ignore-file
import 'package:get_it/get_it.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/config/app_config.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/data/repository/weather_repository_impl.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/domain/repository/weather_repository.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/domain/usecase/index.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather/weather.dart';

void initWeather(GetIt serviceLocator) {
  final WeatherFactory wf = WeatherFactory(AppConfig.weatherApiKey);

  serviceLocator
    // weather factory
    ..registerLazySingleton(() => wf)
    // Datasource
    ..registerFactory<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(serviceLocator()),
    )
    // Repository
    ..registerFactory<WeatherRepository>(
      () => WeatherRepositoryImpl(serviceLocator()),
    )
    // Usecase
    ..registerFactory(
      () => GetCurrentWeather(serviceLocator()),
    )
    ..registerFactory(
      () => GetWeatherForFiveDays(serviceLocator()),
    )
    // Bloc
    ..registerFactory(
      () => WeatherBloc(
        getCurrentWeather: serviceLocator(),
        getWeatherForFiveDays: serviceLocator(),
        permissionService: serviceLocator(),
        locationService: serviceLocator(),
      ),
    );
}
