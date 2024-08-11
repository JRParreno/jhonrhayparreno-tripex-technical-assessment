import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/common/cubit/app_user_cubit.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/common/entities/user_entity.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/config/shared_prefences_keys.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/notifier/shared_preferences_notifier.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/usecase/usecase.dart';

import '../../domain/usecase/index.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SharedPreferencesNotifier _sharedPreferencesNotifier;
  final UserGoogleSignin _userGoogleSignin;
  final AppUserCubit _appUserCubit;
  final UserLogout _userLogout;

  AuthBloc({
    required SharedPreferencesNotifier sharedPreferencesNotifier,
    required AppUserCubit appUserCubit,
    required UserGoogleSignin userGoogleSignin,
    required UserLogout userLogout,
  })  : _sharedPreferencesNotifier = sharedPreferencesNotifier,
        _appUserCubit = appUserCubit,
        _userGoogleSignin = userGoogleSignin,
        _userLogout = userLogout,
        super(AuthInitial()) {
    on<AuthGoogleSignInEvent>(onAuthGoogleSignInEvent);
    on<AuthUserLogout>(onAuthUserLogout);
  }

  Future<void> onAuthUserLogout(
      AuthUserLogout event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userLogout(NoParams());

    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) {
        _sharedPreferencesNotifier.setValue(
            SharedPreferencesKeys.isLoggedIn, false);
        _appUserCubit.logout();

        emit(AuthInitial());
      },
    );
  }

  Future<void> onAuthGoogleSignInEvent(
      AuthGoogleSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final response = await _userGoogleSignin(NoParams());

    response.fold(
      (l) {
        _appUserCubit.failSetUser(l.message);
        emit(AuthFailure(l.message));
      },
      (r) {
        _sharedPreferencesNotifier.setValue(
            SharedPreferencesKeys.isLoggedIn, true);
        _appUserCubit.updateUser(r);
        emit(AuthSuccess(r));
      },
    );
  }
}
