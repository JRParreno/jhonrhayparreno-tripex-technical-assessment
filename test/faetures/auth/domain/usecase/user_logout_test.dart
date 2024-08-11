import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/failure.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/usecase/usecase.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/domain/repository/auth_repository.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/domain/usecase/index.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_logout_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<AuthRepository>(),
  ],
)
void main() {
  late UserLogout usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = UserLogout(mockAuthRepository);
    provideDummy<Either<Failure, String>>(
      const Right('Successfully logout'),
    );
    provideDummy<Either<Failure, void>>(
      Left(
        Failure(),
      ),
    );
  });

  test('Should success logout', () async {
    when(mockAuthRepository.logout())
        .thenAnswer((_) async => const Right('Successfully logout.'));

    final result = await usecase.call(NoParams());

    expect(result.isRight(), true);
    verify(mockAuthRepository.logout());
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('Should fail logout', () async {
    when(mockAuthRepository.logout()).thenAnswer(
      (_) async => Left(Failure()),
    );

    final result = await usecase.call(NoParams());

    result.fold(
      (l) {
        expect(l, isA<Failure>());
      },
      (r) => null,
    );
    verify(mockAuthRepository.logout());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
