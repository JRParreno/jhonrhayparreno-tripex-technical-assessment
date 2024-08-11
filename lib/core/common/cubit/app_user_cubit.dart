// coverage:ignore-file
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/common/entities/user_entity.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/config/shared_prefences_keys.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/firebase/auth_service.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/notifier/shared_preferences_notifier.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/data/models/user_model.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final SharedPreferencesNotifier _sharedPreferencesNotifier;
  final AuthService _authService;

  AppUserCubit({
    required SharedPreferencesNotifier sharedPreferencesNotifier,
    required AuthService authService,
  })  : _sharedPreferencesNotifier = sharedPreferencesNotifier,
        _authService = authService,
        super(GettingAppUser());

  void updateUser(UserEntity? user) {
    if (user == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserLoggedIn(user));
    }
  }

  void logout() {
    emit(AppUserInitial());
  }

  void failSetUser(String message) {
    emit(AppUserFail(message));
  }

  void userLoggedIn() {
    emit(GettingAppUser());
  }

  void getCurrentUser() {
    final isLoggedIn = _sharedPreferencesNotifier.getValue(
        SharedPreferencesKeys.isLoggedIn, false);
    if (isLoggedIn) {
      final currentUser = _authService.currentUser;
      if (currentUser == null) {
        _sharedPreferencesNotifier.setValue(
            SharedPreferencesKeys.isLoggedIn, false);
        return;
      }
      emit(
        AppUserLoggedIn(
          UserModel.fromFirebaseUser(currentUser),
        ),
      );
    }
  }
}
