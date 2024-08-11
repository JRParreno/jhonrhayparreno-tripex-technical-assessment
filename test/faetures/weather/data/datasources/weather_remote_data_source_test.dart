import 'package:flutter_test/flutter_test.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/exceptions.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/weather.dart';

import 'weather_remote_data_source_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<WeatherFactory>(),
    MockSpec<Weather>(),
  ],
)
void main() {
  late MockWeatherFactory mockWeatherFactory;
  late MockWeather mockWeather;
  late WeatherRemoteDataSource weatherRemoteDataSource;

  setUp(() {
    mockWeatherFactory = MockWeatherFactory();
    mockWeather = MockWeather();
    weatherRemoteDataSource = WeatherRemoteDataSourceImpl(mockWeatherFactory);
  });

  const mockLatitude = 12.120;
  const mockLongitude = 8.120;

  group('Success Weather repository Remote data source', () {
    test('Should getCurrentWeather when currentWeatherByLocation is called.',
        () async {
      when(weatherRemoteDataSource.getCurrentWeather(
              latitude: mockLatitude, longitude: mockLongitude))
          .thenAnswer(
        (_) async => mockWeather,
      );

      final result = await mockWeatherFactory.currentWeatherByLocation(
        mockLatitude,
        mockLongitude,
      );

      expect(result, mockWeather);
    });

    test('Should getCurrentWeather when currentWeatherByLocation is called.',
        () async {
      when(weatherRemoteDataSource.getWeatherForFiveDays(
        latitude: mockLatitude,
        longitude: mockLongitude,
      )).thenAnswer(
        (_) async => [mockWeather],
      );

      final result = await mockWeatherFactory.fiveDayForecastByLocation(
        mockLatitude,
        mockLongitude,
      );

      expect(result, [mockWeather]);
    });
  });

  group('Exception Weather repository Remote data source', () {
    const errorMessage = 'An error occurred during getting weather';

    test(
        'Should getCurrentWeather return ServerException when currentWeatherByLocation is called.',
        () async {
      when(mockWeatherFactory.currentWeatherByLocation(
        mockLatitude,
        mockLongitude,
      )).thenThrow(Exception(errorMessage));

      expect(
          () async => await weatherRemoteDataSource.getCurrentWeather(
                latitude: mockLatitude,
                longitude: mockLongitude,
              ),
          throwsA(isA<ServerException>()));
    });

    test(
        'Should getCurrentWeather return ServerException when currentWeatherByLocation is called.',
        () async {
      when(
        mockWeatherFactory.fiveDayForecastByLocation(
          mockLatitude,
          mockLongitude,
        ),
      ).thenThrow(Exception(errorMessage));

      expect(
        () async => await weatherRemoteDataSource.getWeatherForFiveDays(
            longitude: mockLongitude, latitude: mockLatitude),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
