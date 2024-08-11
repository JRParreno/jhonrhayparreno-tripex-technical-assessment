import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/common/cubit/app_user_cubit.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/router/index.dart';
import 'package:jhon_rhay_parreno_technical_assessment/dependency_injection_config.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/presentation/pages/login_page.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/presentation/pages/weather_page.dart';
import 'package:jhon_rhay_parreno_technical_assessment/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initDependencies();
    await Firebase.initializeApp();
  });

  testWidgets('Google Sign-In and Sign-Out test', (WidgetTester tester) async {
    final router = routerConfig();

    serviceLocator<FirebaseAuth>().authStateChanges().listen((User? user) {
      router.refresh();
    });

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                serviceLocator<AppUserCubit>()..getCurrentUser(),
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

    await tester.pumpAndSettle();

    // Verify the button exists
    expect(find.byKey(const Key('googleSignInButton')), findsOneWidget);

    // Tap the button
    await tester.tap(find.byKey(const Key('googleSignInButton')));
    await tester.pumpAndSettle();

    final User? user = serviceLocator<FirebaseAuth>().currentUser;

    expect(user, isNotNull);
    expect(user!.displayName, isNotEmpty);
    expect(user.email, isNotEmpty);

    expect(find.byType(WeatherPage), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Verify the button exists
    expect(find.byKey(const Key('logoutButton')), findsOneWidget);

    // Tap the button
    await tester.tap(find.byKey(const Key('logoutButton')));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog),
        findsOneWidget); // Assuming it's an AlertDialog
    // Verify the logout dialog exists
    expect(find.byKey(const Key('logoutDialogButton')), findsOneWidget);

    // Tap the button
    await tester.tap(find.byKey(const Key('logoutDialogButton')));
    await tester.pump(const Duration(seconds: 3));

    expect(find.byType(LoginPage), findsOneWidget);
    final User? isUserLogged = serviceLocator<FirebaseAuth>().currentUser;
    expect(isUserLogged, isNull);
  });
}
