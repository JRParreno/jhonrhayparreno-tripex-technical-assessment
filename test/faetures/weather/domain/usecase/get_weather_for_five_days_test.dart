import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/failure.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/domain/repository/weather_repository.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/domain/usecase/get_weather_for_five_days.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/domain/usecase/index.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/weather.dart';

import 'get_weather_for_five_days_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<WeatherRepository>(),
    MockSpec<Weather>(),
  ],
)
void main() {
  late GetWeatherForFiveDays usecase;
  late MockWeatherRepository mockWeatherRepository;
  late MockWeather mockWeather;

  setUp(() {
    mockWeather = MockWeather();
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetWeatherForFiveDays(mockWeatherRepository);
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
  });

  const mockLatitude = 12.120;
  const mockLongitude = 8.120;

  test('Should success get the five days weather based on location', () async {
    when(mockWeatherRepository.getWeatherForFiveDays(
      latitude: mockLatitude,
      longitude: mockLongitude,
    )).thenAnswer(
      (_) async => Right([mockWeather]),
    );

    final result = await usecase.call(
      GetWeatherForFiveDaysParams(
        longitude: mockLongitude,
        latitude: mockLatitude,
      ),
    );

    result.fold(
      (l) => null,
      (r) {
        expect(r, isA<List<Weather>>());
      },
    );
    // Verify that the method has been called on the Repository
    verify(mockWeatherRepository.getWeatherForFiveDays(
      longitude: mockLongitude,
      latitude: mockLatitude,
    ));
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockWeatherRepository);
  });

  test('Should fail get the five days weather based on location', () async {
    when(mockWeatherRepository.getWeatherForFiveDays(
      longitude: mockLongitude,
      latitude: mockLatitude,
    )).thenAnswer(
      (_) async => Left(Failure()),
    );

    final result = await usecase.call(
      GetWeatherForFiveDaysParams(
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
    verify(mockWeatherRepository.getWeatherForFiveDays(
      longitude: mockLongitude,
      latitude: mockLatitude,
    ));
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}
