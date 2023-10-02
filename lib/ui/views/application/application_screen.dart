import 'package:chat_connect/bloc/bloc.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationScreen extends StatefulWidget {
  final Widget child;
  const ApplicationScreen({super.key, required this.child});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.authStatus == AuthStatus.error) {
              print(state.message);
            }
          },
          child: BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserError) {
                print(state.message);
              }
            },
            builder: (context, state) {
              if (state is UserLoading) {
                return loadingWidget();
              }
              if (state.userModel.id.isNotEmpty) {
                return BlocBuilder<ApplicationBloc, ApplicationState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: 375.w,
                      height: 812.h,
                      child: Scaffold(
                        body: widget.child,
                        bottomNavigationBar: bottomNavigationBarWidget(),
                      )
                    );
                  },
                );
              }
              return Container();
            },
          ),
        );
  }
}

