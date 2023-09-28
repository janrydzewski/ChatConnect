import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:chat_connect/bloc/bloc.dart';
import 'package:chat_connect/router/router.dart';

import 'repositories/repositories.dart';

void main() async {
  Bloc.observer = MyBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  MyRouter myRouter = MyRouter();

  runApp(MyApp(
    router: myRouter.router,
  ));
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  const MyApp({
    Key? key,
    required this.router,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => const AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => const ChatRepository(),
        ),
        RepositoryProvider(
          create: (context) => const UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => const MessageRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ApplicationBloc(),
          ),
          BlocProvider(
            create: (context) => AuthBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context)),
          ),
          BlocProvider(
            create: (context) => ChatBloc(
                chatRepository: RepositoryProvider.of<ChatRepository>(context)),
          ),
          BlocProvider(
            create: (context) => UserBloc(
                userRepository: RepositoryProvider.of<UserRepository>(context)),
          ),
          BlocProvider(
            create: (context) => EditProfileBloc(
                userRepository: RepositoryProvider.of<UserRepository>(context)),
          ),
          BlocProvider(
            create: (context) => MessageBloc(
                messageRepository:
                    RepositoryProvider.of<MessageRepository>(context)),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
          ),
        ),
      ),
    );
  }
}
