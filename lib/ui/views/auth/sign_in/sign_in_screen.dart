import 'package:chat_connect/resources/colors/colors.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375.w,
      height: 812.h,
      child: Scaffold(
        backgroundColor: ColorProvider.secondaryBackground,
        body: Container(
          width: 375.w,
          height: 812.h,
          margin: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 100.h,
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
              SizedBox(height: 65.h,),
              reusableAuthTextField("Email", emailController),
              SizedBox(height: 30.h,),
              reusableAuthTextField("Password", passwordController),
              SizedBox(height: 65.h,),
              reusableAuthButton("Confirm", () => null),
              reusableAuthChangeCardText("Don't have an account yet? Sign Up", () {
                context.go("/signUp");
              }),
            ],
          ),
        ),
      ),
    );
  }
}
