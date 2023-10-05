import 'package:chat_connect/resources/resources.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyRouter {
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  late final GoRouter router = GoRouter(
    initialLocation: firebaseAuth.currentUser == null ? '/signIn' : '/community',
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/signUp',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const SignUpScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: '/signIn',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const SignInScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return ApplicationScreen(
            child: child,
          );
        },
        routes: <RouteBase>[
          GoRoute(
            name: 'Community',
            path: '/community',
            pageBuilder: (context, state) {
              return  const NoTransitionPage(
                child: CommunityScreen(),
              );
            },
          ),
          GoRoute(
            name: 'Chat',
            path: '/chat',
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: ChatScreen());
            },
            routes: <RouteBase>[
              GoRoute(
            name: 'Search',
            path: 'search',
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: SearchScreen());
            },
            
          ),
            ]
          ),
          GoRoute(
            name: 'Profile',
            path: '/profile',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: ProfileScreen(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        name: "Message",
        path: '/message',
        pageBuilder: (context, state) {
          final map = state.extra as Map<String, String>;
          return CustomTransitionPage(
            child: MessagesScreen(
              chatId: map['chatRoomId']!,
              receiverName: map['receiverName']!,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
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
