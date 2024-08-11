import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/exceptions.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/failure.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/data/repository/weather_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/weather.dart';

import 'weather_repository_impl_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<WeatherRemoteDataSource>(),
    MockSpec<Weather>(),
  ],
)
void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;
  late MockWeather mockWeather;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(mockWeatherRemoteDataSource);
    mockWeather = MockWeather();
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

  group('Success Weather repository impl', () {
    test(
        'Should return remote data when getCurrentWeather is call to remote data source is successful',
        () async {
      when(mockWeatherRemoteDataSource.getCurrentWeather(
        latitude: mockLatitude,
        longitude: mockLongitude,
      )).thenAnswer(
        (_) async => mockWeather,
      );

      final result = await weatherRepositoryImpl.getCurrentWeather(
        latitude: mockLatitude,
        longitude: mockLongitude,
      );

      result.fold(
        (l) => null,
        (r) {
          expect(r, isA<Weather>());
        },
      );
      verify(mockWeatherRemoteDataSource.getCurrentWeather(
        latitude: mockLatitude,
        longitude: mockLongitude,
      ));
      verifyNoMoreInteractions(mockWeatherRemoteDataSource);
    });

    test(
        'Should return remote data when getWeatherForFiveDays is call to remote data source is successful',
        () async {
      when(mockWeatherRemoteDataSource.getWeatherForFiveDays(
        latitude: mockLatitude,
        longitude: mockLongitude,
      )).thenAnswer(
        (_) async => [mockWeather],
      );

      final result = await weatherRepositoryImpl.getWeatherForFiveDays(
        latitude: mockLatitude,
        longitude: mockLongitude,
      );

      result.fold(
        (l) => null,
        (r) {
          expect(r, isA<List<Weather>>());
        },
      );
      // Verify that the method has been called on the Repository
      verify(mockWeatherRemoteDataSource.getWeatherForFiveDays(
        latitude: mockLatitude,
        longitude: mockLongitude,
      ));
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockWeatherRemoteDataSource);
    });
  });

  group('Failure Weather repository impl', () {
    const errorMessage = 'error occured';

    group('getCurrentWeather', () {
      test('Should throw Failure when getCurrentWeather is call', () async {
        when(mockWeatherRemoteDataSource.getCurrentWeather(
          latitude: mockLatitude,
          longitude: mockLongitude,
        )).thenThrow(Failure());

        final result = await weatherRepositoryImpl.getCurrentWeather(
          latitude: mockLatitude,
          longitude: mockLongitude,
        );

        result.fold(
          (l) {
            expect(l, isA<Failure>());
          },
          (r) => null,
        );
      });

      test('Should throw ServerException when getCurrentWeather is call',
          () async {
        when(mockWeatherRemoteDataSource.getCurrentWeather(
          latitude: mockLatitude,
          longitude: mockLongitude,
        )).thenThrow(ServerException(errorMessage));

        final result = await weatherRepositoryImpl.getCurrentWeather(
          latitude: mockLatitude,
          longitude: mockLongitude,
        );
        expect(result, equals(left(ServerException(errorMessage))));
      });
    });

    group('getWeatherForFiveDays', () {
      test('Should throw Failure when getWeatherForFiveDays is call', () async {
        when(mockWeatherRemoteDataSource.getWeatherForFiveDays(
          latitude: mockLatitude,
          longitude: mockLongitude,
        )).thenThrow(Failure());

        final result = await weatherRepositoryImpl.getWeatherForFiveDays(
          latitude: mockLatitude,
          longitude: mockLongitude,
        );

        result.fold(
          (l) {
            expect(l, isA<Failure>());
          },
          (r) => null,
        );
      });

      test('Should throw ServerException when getWeatherForFiveDays is call',
          () async {
        when(mockWeatherRemoteDataSource.getWeatherForFiveDays(
          latitude: mockLatitude,
          longitude: mockLongitude,
        )).thenThrow(ServerException(errorMessage));

        final result = await weatherRepositoryImpl.getWeatherForFiveDays(
          latitude: mockLatitude,
          longitude: mockLongitude,
        );
        expect(result, equals(left(ServerException(errorMessage))));
      });
    });
  });
}
