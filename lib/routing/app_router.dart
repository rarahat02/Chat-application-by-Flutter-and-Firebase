import 'package:chat_app_firebase_riverpod/features/auth/ui/get_started_screen.dart';
import 'package:chat_app_firebase_riverpod/features/auth/ui/login_screen.dart';
import 'package:chat_app_firebase_riverpod/features/auth/ui/register_screen.dart';
import 'package:chat_app_firebase_riverpod/features/chat/ui/chat_page.dart';
import 'package:chat_app_firebase_riverpod/features/home/ui/home_screen.dart';
import 'package:chat_app_firebase_riverpod/providers/firebase_providers.dart';
import 'package:chat_app_firebase_riverpod/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

enum AppRoute { getStarted, home, register, login, chat, notifications }

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  // ignore: avoid_manual_providers_as_generated_provider_dependency
  final authState = ref.watch(authStateProvider);
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final isLoggedIn = authState.value != null;
      final path = state.uri.path;
      if (isLoggedIn) {
        if (path == '/' ||
            path == '/$loginRoute' ||
            path == '/$registerRoute') {
          return '/$homeRoute';
        }
      } else {
        if (path == '/' ||
            path == '/$homeRoute' ||
            path == '/$chatRoute' ||
            path == '/$notificationsRoute') {
          return '/$getStartedRoute';
        }
      }
      return null;
    },
    //refreshListenable: GoRouterRefreshStream(firebaseAuthServiceProvider.authStateChange),
    routes: [
      GoRoute(
          path: '/$getStartedRoute',
          name: AppRoute.getStarted.name,
          builder: (context, state) => const GetStartedScreen(),
          routes: [
            GoRoute(
                path: loginRoute,
                name: AppRoute.login.name,
                builder: (context, state) {
                  return const LoginScreen();
                }),
            GoRoute(
                path: registerRoute,
                name: AppRoute.register.name,
                builder: (context, state) {
                  return const RegisterScreen();
                }),
          ]),
      GoRoute(
          path: '/$homeRoute',
          name: AppRoute.home.name,
          builder: (context, state) {
            return const HomeScreen();
          },
          routes: [
            GoRoute(
              path: '$chatRoute/:userId',
              name: AppRoute.chat.name,
              builder: (BuildContext context, GoRouterState state) {
                final extras = state.extra as Map<String, dynamic>?;
                final String userId =
                    state.pathParameters['userId'] ?? 'defaultUserId';
                final String userName =
                    extras?['userName'] as String? ?? 'defaultUserName';
                final String userEmail =
                    extras?['userEmail'] as String? ?? 'defaultUserEmail';

                return ChatPage(
                    userId: userId, userName: userName, userEmail: userEmail);
              },
            ),
            GoRoute(
                path: notificationsRoute,
                name: AppRoute.notifications.name,
                builder: (context, state) {
                  return const RegisterScreen();
                }),
          ]),
    ],
    errorBuilder: (context, state) => const SizedBox(),
  );
}
