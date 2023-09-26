import 'package:chat_connect/ui/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyRouter {
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  late final GoRouter router = GoRouter(
    initialLocation: '/home',
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return ApplicationScreen(
            child: child,
          );
        },
        routes: <RouteBase>[
          GoRoute(
            name: 'Home',
            path: '/home',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: Text(
                  "Home",
                  style: TextStyle(color: Colors.black),
                ),
              );
            },
          ),
          GoRoute(
            name: 'Chat',
            path: '/chat',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: Text(
                  "Chat",
                  style: TextStyle(color: Colors.black),
                ),
              );
            },
          ),
          GoRoute(
            name: 'Profile',
            path: '/profile',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: FlutterLogo()
              );
            },
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) => CustomTransitionPage(
      child: const Center(
        child: Text("Error"),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
  );
}
