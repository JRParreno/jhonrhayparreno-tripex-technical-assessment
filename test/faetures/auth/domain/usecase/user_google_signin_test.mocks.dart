// Mocks generated by Mockito 5.4.4 from annotations
// in jhon_rhay_parreno_technical_assessment/test/faetures/auth/domain/usecase/user_google_signin_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:fpdart/fpdart.dart' as _i4;
import 'package:jhon_rhay_parreno_technical_assessment/core/common/entities/user_entity.dart'
    as _i6;
import 'package:jhon_rhay_parreno_technical_assessment/core/error/failure.dart'
    as _i5;
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/domain/repository/auth_repository.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i7;

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

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i2.AuthRepository {
  @override
  _i3.Future<_i4.Either<_i5.Failure, _i6.UserEntity>> signinWithGoogle() =>
      (super.noSuchMethod(
        Invocation.method(
          #signinWithGoogle,
          [],
        ),
        returnValue: _i3.Future<_i4.Either<_i5.Failure, _i6.UserEntity>>.value(
            _i7.dummyValue<_i4.Either<_i5.Failure, _i6.UserEntity>>(
          this,
          Invocation.method(
            #signinWithGoogle,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure, _i6.UserEntity>>.value(
                _i7.dummyValue<_i4.Either<_i5.Failure, _i6.UserEntity>>(
          this,
          Invocation.method(
            #signinWithGoogle,
            [],
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure, _i6.UserEntity>>);

  @override
  _i3.Future<_i4.Either<_i5.Failure, String>> logout() => (super.noSuchMethod(
        Invocation.method(
          #logout,
          [],
        ),
        returnValue: _i3.Future<_i4.Either<_i5.Failure, String>>.value(
            _i7.dummyValue<_i4.Either<_i5.Failure, String>>(
          this,
          Invocation.method(
            #logout,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure, String>>.value(
                _i7.dummyValue<_i4.Either<_i5.Failure, String>>(
          this,
          Invocation.method(
            #logout,
            [],
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure, String>>);
}
