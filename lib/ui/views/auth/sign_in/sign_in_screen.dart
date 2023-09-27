import 'package:chat_connect/bloc/bloc.dart';
import 'package:chat_connect/resources/colors/colors.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignInScreen> {
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
          child: Container(
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
                reusableAuthText("Sign In"),
                SizedBox(
                  height: 65.h,
                ),
                Form(
                  key: _formKey,
                  child: Column(children: [
                reusableAuthTextField("Email", _emailController),
                  SizedBox(
                    height: 30.h,
                  ),
                  reusableAuthTextField("Password", _passwordController),
                  ],),
                ),
                
                SizedBox(
                  height: 65.h,
                ),
                reusableAuthButton("Confirm", () {
                  _formKey.currentState!.validate() ? 
                  context.read<AuthBloc>().add(
                        SignInEvent(
                            _emailController.text, _passwordController.text),
                      ) : null ;
                }),
                reusableAuthChangeCardText("Don't have an account yet? Sign Up",
                    () {
                  context.go("/signUp");
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
