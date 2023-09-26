import 'package:chat_connect/resources/colors/colors.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
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
              reusableAuthText("Sign Up"),
              reusableAuthTextField("First Name", firstNameController),
              reusableAuthTextField("Last Name", lastNameController),
              reusableAuthTextField("Email", emailController),
              reusableAuthTextField("Password", passwordController),
              reusableAuthButton("Confirm", () => null),
              reusableAuthChangeCardText(
                  "Already have an account? Sign In", () {
                    context.go("/signIn");
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
