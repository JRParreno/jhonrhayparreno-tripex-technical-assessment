// Mocks generated by Mockito 5.4.4 from annotations
// in jhon_rhay_parreno_technical_assessment/test/faetures/weather/domain/usecase/get_weather_for_five_days_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:fpdart/fpdart.dart' as _i4;
import 'package:jhon_rhay_parreno_technical_assessment/core/error/failure.dart'
    as _i5;
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/domain/repository/weather_repository.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i7;
import 'package:weather/weather.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [WeatherRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherRepository extends _i1.Mock implements _i2.WeatherRepository {
  @override
  _i3.Future<_i4.Either<_i5.Failure, _i6.Weather>> getCurrentWeather({
    required double? longitude,
    required double? latitude,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrentWeather,
          [],
          {
            #longitude: longitude,
            #latitude: latitude,
          },
        ),
        returnValue: _i3.Future<_i4.Either<_i5.Failure, _i6.Weather>>.value(
            _i7.dummyValue<_i4.Either<_i5.Failure, _i6.Weather>>(
          this,
          Invocation.method(
            #getCurrentWeather,
            [],
            {
              #longitude: longitude,
              #latitude: latitude,
            },
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure, _i6.Weather>>.value(
                _i7.dummyValue<_i4.Either<_i5.Failure, _i6.Weather>>(
          this,
          Invocation.method(
            #getCurrentWeather,
            [],
            {
              #longitude: longitude,
              #latitude: latitude,
            },
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure, _i6.Weather>>);

  @override
  _i3.Future<_i4.Either<_i5.Failure, List<_i6.Weather>>> getWeatherForFiveDays({
    required double? longitude,
    required double? latitude,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWeatherForFiveDays,
          [],
          {
            #longitude: longitude,
            #latitude: latitude,
          },
        ),
        returnValue:
            _i3.Future<_i4.Either<_i5.Failure, List<_i6.Weather>>>.value(
                _i7.dummyValue<_i4.Either<_i5.Failure, List<_i6.Weather>>>(
          this,
          Invocation.method(
            #getWeatherForFiveDays,
            [],
            {
              #longitude: longitude,
              #latitude: latitude,
            },
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure, List<_i6.Weather>>>.value(
                _i7.dummyValue<_i4.Either<_i5.Failure, List<_i6.Weather>>>(
          this,
          Invocation.method(
            #getWeatherForFiveDays,
            [],
            {
              #longitude: longitude,
              #latitude: latitude,
            },
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure, List<_i6.Weather>>>);
}

/// A class which mocks [Weather].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeather extends _i1.Mock implements _i6.Weather {}
