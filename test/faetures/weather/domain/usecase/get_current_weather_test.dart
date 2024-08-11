import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/failure.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/domain/repository/weather_repository.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/domain/usecase/index.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/weather.dart';

import 'get_current_weather_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<WeatherRepository>(),
    MockSpec<Weather>(),
  ],
)
void main() {
  late GetCurrentWeather usecase;
  late MockWeatherRepository mockWeatherRepository;
  late MockWeather mockWeather;

  setUp(() {
    mockWeather = MockWeather();
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetCurrentWeather(mockWeatherRepository);
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

  const mockLatitude = 12.120;
  const mockLongitude = 8.120;

  test('Should success get the current weather based on location', () async {
    when(mockWeatherRepository.getCurrentWeather(
      latitude: mockLatitude,
      longitude: mockLongitude,
    )).thenAnswer(
      (_) async => Right(mockWeather),
    );

    final result = await usecase.call(
      GetCurrentWeatherParams(
        longitude: mockLongitude,
        latitude: mockLatitude,
      ),
    );

    result.fold(
      (l) => null,
      (r) {
        expect(r, isA<Weather>());
      },
    );
    // Verify that the method has been called on the Repository
    verify(mockWeatherRepository.getCurrentWeather(
      longitude: mockLongitude,
      latitude: mockLatitude,
    ));
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockWeatherRepository);
  });

  test('Should fail get the current weather based on location', () async {
    when(mockWeatherRepository.getCurrentWeather(
      longitude: mockLongitude,
      latitude: mockLatitude,
    )).thenAnswer(
      (_) async => Left(Failure()),
    );

    final result = await usecase.call(
      GetCurrentWeatherParams(
        longitude: mockLongitude,
        latitude: mockLatitude,
      ),
    );

    result.fold(
      (l) {
        expect(l, isA<Failure>());
      },
      (r) => null,
    );
    // Verify that the method has been called on the Repository
    verify(mockWeatherRepository.getCurrentWeather(
      longitude: mockLongitude,
      latitude: mockLatitude,
    ));
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}
