import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/common/entities/user_entity.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/failure.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/usecase/usecase.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/domain/repository/auth_repository.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/domain/usecase/index.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_google_signin_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<AuthRepository>(),
  ],
)
void main() {
  late UserGoogleSignin usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = UserGoogleSignin(mockAuthRepository);
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

  const UserEntity userEntity = UserEntity(
    id: '1',
    email: 'juandelacruz@gmail.com',
  );

  test('Should success sigin in using Google', () async {
    when(mockAuthRepository.signinWithGoogle()).thenAnswer(
      (_) async => const Right(userEntity),
    );

    final result = await usecase.call(NoParams());

    result.fold(
      (l) => null,
      (r) {
        expect(r, isA<UserEntity>());
        expect(r.id, userEntity.id);
        expect(r.email, userEntity.email);
      },
    );
    // Verify that the method has been called on the Repository
    verify(mockAuthRepository.signinWithGoogle());
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('Should fail sigin in using Google', () async {
    when(mockAuthRepository.signinWithGoogle()).thenAnswer(
      (_) async => Left(Failure()),
    );

    final result = await usecase.call(NoParams());

    result.fold(
      (l) {
        expect(l, isA<Failure>());
      },
      (r) => null,
    );
    // Verify that the method has been called on the Repository
    verify(mockAuthRepository.signinWithGoogle());
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
