import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/firebase/auth_service.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/router/index.dart';
import 'package:jhon_rhay_parreno_technical_assessment/dependency_injection_config.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/presentation/pages/login_page.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/presentation/pages/weather_page.dart';

GoRouter routerConfig() {
  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'mainNavigator');

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: kDebugMode,
    initialLocation: AppRoutes.login.path,
    redirect: (BuildContext context, GoRouterState state) async {
      final isLoggedIn = serviceLocator<AuthService>().currentUser != null;
      final loggingIn = state.matchedLocation == AppRoutes.login.path;
      final signingIn = state.matchedLocation == AppRoutes.signup.path;

      if (isLoggedIn && (loggingIn || signingIn)) {
        return AppRoutes.home.path;
      }

      if (!isLoggedIn) {
        return AppRoutes.login.path;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login.path,
        name: AppRoutes.login.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: const LoginPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.home.path,
        name: AppRoutes.home.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: const WeatherPage(),
          );
        },
      ),
    ],
  );
}

CustomTransitionPage buildTransitionPage({
  required LocalKey localKey,
  required Widget child,
}) {
  return CustomTransitionPage(
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.linearToEaseOut).animate(animation),
        child: child,
      );
    },
    key: localKey,
    child: child,
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
