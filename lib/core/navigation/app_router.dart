import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:magic_slides/feature/authentication/view/statemachine/authentication_view.dart';
import 'package:magic_slides/feature/home/view/home_view.dart';

class ScreenPaths {
  static const String login = '/login';
  static const String home = '/home';
}

class AppRouter {
  static final GoRouterRefreshStream _refreshListenable = GoRouterRefreshStream(
    Supabase.instance.client.auth.onAuthStateChange,
  );

  static final GoRouter routerConfig = GoRouter(
    refreshListenable: _refreshListenable,
    initialLocation: ScreenPaths.login,

    redirect: (context, state) {
      final session = Supabase.instance.client.auth.currentSession;
      final loggedIn = session != null;

      final isGoingToLogin = state.uri.toString() == ScreenPaths.login;

      if (!loggedIn && !isGoingToLogin) {
        return ScreenPaths.login;
      }

      if (loggedIn && isGoingToLogin) {
        return ScreenPaths.home;
      }

      return null;
    },

    routes: [
      GoRoute(
        path: ScreenPaths.login,
        builder: (context, state) => const AuthenticationView(),
      ),
      GoRoute(
        path: ScreenPaths.home,
        builder: (context, state) => const HomeView(),
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  final Stream _stream;
  late final StreamSubscription _sub;

  GoRouterRefreshStream(this._stream) {
    _sub = _stream.listen(
      (event) {
        notifyListeners();
      },
      onError: (err) {
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
