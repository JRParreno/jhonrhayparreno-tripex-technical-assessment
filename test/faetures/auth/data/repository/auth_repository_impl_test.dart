import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/common/entities/user_entity.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/exceptions.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/failure.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/data/models/user_model.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/data/repository/auth_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<AuthRemoteDataSource>(),
  ],
)
void main() {
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late AuthRepositoryImpl authRepositoryImpl;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    authRepositoryImpl = AuthRepositoryImpl(mockAuthRemoteDataSource);

    provideDummy<Either<Failure, UserEntity>>(
      const Right(
        UserEntity(email: 'juandelacruz@gmail.com', id: '1'),
      ),
    );
    provideDummy<Either<Failure, UserEntity>>(
      Left(
        Failure(),
      ),
    );
  });

  final UserModel mockUserEntity = UserModel(
    id: '1',
    email: 'juandelacruz@gmail.com',
  );

  group('Success Auth repository impl', () {
    test(
        'Should return remote data when googleSignin is call to remote data source is successful',
        () async {
      when(mockAuthRemoteDataSource.signinWithGoogle()).thenAnswer(
        (_) async => mockUserEntity,
      );

      final result = await authRepositoryImpl.signinWithGoogle();

      result.fold(
        (l) => null,
        (r) {
          expect(r, isA<UserEntity>());
          expect(r.id, mockUserEntity.id);
          expect(r.email, mockUserEntity.email);
        },
      );
      // Verify that the method has been called on the Repository
      verify(mockAuthRemoteDataSource.signinWithGoogle());
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockAuthRemoteDataSource);
    });

    test(
        'Should return remote data when logout is call to remote data source is successful',
        () async {
      when(mockAuthRemoteDataSource.logout()).thenAnswer(
        (_) async => "Successfully logout.",
      );

      final result = await authRepositoryImpl.logout();

      expect(result.isRight(), true);
      // Verify that the method has been called on the Repository
      verify(mockAuthRemoteDataSource.logout());
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockAuthRemoteDataSource);
    });
  });

  group('Failure Auth repository impl', () {
    const errorMessage = 'error occured';

    group('google signin', () {
      test('Should throw Failure when signinWithGoogle is call', () async {
        when(mockAuthRemoteDataSource.signinWithGoogle()).thenThrow(Failure());

        final result = await authRepositoryImpl.signinWithGoogle();

        result.fold(
          (l) {
            expect(l, isA<Failure>());
          },
          (r) => null,
        );
      });

      test('Should throw AuthenticationException when signinWithGoogle is call',
          () async {
        when(mockAuthRemoteDataSource.signinWithGoogle())
            .thenThrow(AuthenticationException(errorMessage));

        final result = await authRepositoryImpl.signinWithGoogle();

        expect(result, equals(left(AuthenticationException(errorMessage))));
      });

      test('Should throw FirebaseException when signinWithGoogle is call',
          () async {
        when(mockAuthRemoteDataSource.signinWithGoogle())
            .thenThrow(FirebaseException(errorMessage));

        final result = await authRepositoryImpl.signinWithGoogle();

        expect(result, equals(left(FirebaseException(errorMessage))));
      });
    });

    group('logout', () {
      test('Should throw Failure when logout is call', () async {
        when(mockAuthRemoteDataSource.logout()).thenThrow(
          (_) async => Failure(),
        );

        final result = await authRepositoryImpl.logout();

        result.fold(
          (l) {
            expect(l, isA<Failure>());
          },
          (r) => null,
        );
      });

      test('Should throw AuthenticationException when logout is call',
          () async {
        when(mockAuthRemoteDataSource.logout())
            .thenThrow(AuthenticationException(errorMessage));

        final result = await authRepositoryImpl.logout();

        expect(result, equals(left(AuthenticationException(errorMessage))));
      });
    });
  });
}
