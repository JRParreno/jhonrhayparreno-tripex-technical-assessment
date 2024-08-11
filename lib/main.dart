// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/common/cubit/app_user_cubit.dart';

import 'package:jhon_rhay_parreno_technical_assessment/core/router/index.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/theme/theme.dart';
import 'package:jhon_rhay_parreno_technical_assessment/dependency_injection_config.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:jhon_rhay_parreno_technical_assessment/firebase_options.dart';
import 'package:jhon_rhay_parreno_technical_assessment/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies();

  final router = routerConfig();

  serviceLocator<FirebaseAuth>().authStateChanges().listen((User? user) {
    router.refresh();
  });

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<AppUserCubit>()..getCurrentUser(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<WeatherBloc>(),
        ),
      ],
      child: MyApp(
        goRouter: router,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.goRouter,
  });

  final GoRouter goRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightThemeMode,
      routerConfig: goRouter,
      locale: const Locale('en'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
