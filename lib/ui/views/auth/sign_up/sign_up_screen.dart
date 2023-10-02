import 'package:chat_connect/bloc/bloc.dart';
import 'package:chat_connect/resources/resources.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375.w,
      height: 812.h,
      child: Scaffold(
        backgroundColor: ColorProvider.secondaryBackground,
        body: SafeArea(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.authStatus == AuthStatus.authenticated) {
                context.go('/home');
              }
              if (state.authStatus == AuthStatus.error) {
                showSnackBarError(context, state.message);
              }
            },
            builder: (context, state) {
              if (state.authStatus == AuthStatus.loading) {
                return loadingWidget();
              }
              if (state.authStatus == AuthStatus.unauthenticated) {
                return Container(
                  width: 375.w,
                  height: 812.h,
                  margin: EdgeInsets.symmetric(
                    horizontal: 30.w,
                    vertical: 50.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorProvider.mainBackground,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      reusableAuthText("Sign Up"),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            reusableAuthTextField(
                                "First Name", _firstNameController),
                            reusableAuthTextField(
                                "Last Name", _lastNameController),
                            reusableAuthTextField("Email", _emailController),
                            reusableAuthTextField(
                                "Password", _passwordController),
                          ],
                        ),
                      ),
                      reusableAuthButton("Confirm", () {
                        _formKey.currentState!.validate()
                            ? context.read<AuthBloc>().add(
                                  SignUpEvent(
                                      _firstNameController.text,
                                      _lastNameController.text,
                                      _emailController.text,
                                      _passwordController.text),
                                )
                            : null;
                      }),
                      reusableAuthChangeCardText(
                          "Already have an account? Sign In", () {
                        context.go("/signIn");
                      }),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
