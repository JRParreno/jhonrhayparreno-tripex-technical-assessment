// coverage:ignore-file
import 'package:get_it/get_it.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/common/cubit/app_user_cubit.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/data/repository/auth_repository_impl.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/domain/repository/auth_repository.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/domain/usecase/index.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/presentation/bloc/auth_bloc.dart';

void initAuth(GetIt serviceLocator) {
  serviceLocator
    // Datasource
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        firebaseAuth: serviceLocator(),
        authService: serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    // Usecase
    ..registerFactory(
      () => UserGoogleSignin(serviceLocator()),
    )
    ..registerFactory(
      () => UserLogout(serviceLocator()),
    )
    // Bloc
    ..registerFactory(
      () => AuthBloc(
        sharedPreferencesNotifier: serviceLocator(),
        appUserCubit: serviceLocator(),
        userGoogleSignin: serviceLocator(),
        userLogout: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AppUserCubit(
        sharedPreferencesNotifier: serviceLocator(),
        authService: serviceLocator(),
      ),
    );
}
