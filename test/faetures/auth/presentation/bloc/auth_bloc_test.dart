import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/common/cubit/app_user_cubit.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/common/entities/user_entity.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/config/shared_prefences_keys.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/error/failure.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/notifier/shared_preferences_notifier.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/usecase/usecase.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/domain/repository/auth_repository.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/domain/usecase/index.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<AuthRepository>(),
    MockSpec<AppUserCubit>(),
    MockSpec<SharedPreferencesNotifier>(),
  ],
)
void main() {
  late MockAuthRepository mockAuthRepository;
  late MockAppUserCubit mockAppUserCubit;
  late MockSharedPreferencesNotifier mockSharedPreferencesNotifier;
  late AuthBloc authBloc;
  late UserGoogleSignin userGoogleSignin;
  late UserLogout userLogout;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    userGoogleSignin = UserGoogleSignin(mockAuthRepository);
    userLogout = UserLogout(mockAuthRepository);
    mockAppUserCubit = MockAppUserCubit();
    mockSharedPreferencesNotifier = MockSharedPreferencesNotifier();
    authBloc = AuthBloc(
      sharedPreferencesNotifier: mockSharedPreferencesNotifier,
      appUserCubit: mockAppUserCubit,
      userGoogleSignin: userGoogleSignin,
      userLogout: userLogout,
    );

    provideDummy<Either<Failure, UserEntity>>(
      const Right(
        UserEntity(email: 'juandelacruz@gmail.com', id: '1'),
      ),
    );
    provideDummy<Either<Failure, String>>(
      const Right('Successfully logout'),
    );
    provideDummy<Either<Failure, UserEntity>>(
      Left(
        Failure(),
      ),
    );
  });

  tearDown(() => authBloc.close());

  group(
    AuthBloc,
    () {
      const UserEntity userEntity = UserEntity(
        id: '1',
        email: 'juandelacruz@gmail.com',
      );

      const errorMessage = 'Something went wrong';

      group('onAuthGoogleSignInEvent', () {
        test('AuthGoogleSignInEvent event props', () {
          // Assert
          final event = AuthGoogleSignInEvent();

          // Act
          authBloc.add(event);

          final List<Object?> expectedProps = [];

          // Assert
          expect(event.props, expectedProps);
        });

        blocTest(
          'emits [AuthLoading, AuthSuccess] when Google Sign-In is successful',
          build: () {
            when(userGoogleSignin.call(NoParams()))
                .thenAnswer((_) async => const Right(userEntity));
            return authBloc;
          },
          act: (bloc) => bloc.add(AuthGoogleSignInEvent()),
          expect: () => <AuthState>[
            AuthLoading(),
            const AuthSuccess(userEntity),
          ],
          verify: (_) {
            verify(mockSharedPreferencesNotifier.setValue(
                    SharedPreferencesKeys.isLoggedIn, true))
                .called(1);
            verify(mockAppUserCubit.updateUser(userEntity)).called(1);
          },
        );

        blocTest(
          'emits [AuthLoading, AuthFailure] when Google Sign-In is fail',
          build: () {
            when(userGoogleSignin.call(NoParams()))
                .thenAnswer((_) async => Left(Failure(errorMessage)));
            return authBloc;
          },
          act: (bloc) => bloc.add(AuthGoogleSignInEvent()),
          expect: () => <AuthState>[
            AuthLoading(),
            const AuthFailure(errorMessage),
          ],
          verify: (_) {
            verify(mockAppUserCubit.failSetUser(errorMessage)).called(1);
          },
        );
      });

      group('onAuthUserLogout', () {
        test('AuthUserLogout event props', () {
          // Assert
          final event = AuthUserLogout();

          // Act
          authBloc.add(event);

          final List<Object?> expectedProps = [];

          // Assert
          expect(event.props, expectedProps);
        });

        blocTest(
          'emits [AuthLoading, AuthInitial] when Logout is successful',
          build: () {
            when(userLogout.call(NoParams())).thenAnswer((_) async => const Right(
                'Successfully logout.')); // Ensure Right(null) matches the return type of the function

            return authBloc;
          },
          act: (bloc) => bloc.add(AuthUserLogout()),
          expect: () => <AuthState>[
            AuthLoading(),
            AuthInitial(),
          ],
          verify: (_) {
            verify(mockSharedPreferencesNotifier.setValue(
                    SharedPreferencesKeys.isLoggedIn, false))
                .called(1);
            verify(mockAppUserCubit.logout()).called(1);
          },
        );

        blocTest(
          'emits [AuthLoading, AuthFailure] when Logout is fail',
          build: () {
            when(userLogout.call(NoParams()))
                .thenAnswer((_) async => Left(Failure(errorMessage)));
            return authBloc;
          },
          act: (bloc) => bloc.add(AuthUserLogout()),
          expect: () => <AuthState>[
            AuthLoading(),
            const AuthFailure(errorMessage),
          ],
        );
      });
    },
  );
}
