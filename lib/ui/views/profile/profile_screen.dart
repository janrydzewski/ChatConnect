import 'package:chat_connect/bloc/bloc.dart';
import 'package:chat_connect/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 375.w, height: 812.h, child: Scaffold(backgroundColor: ColorProvider.mainBackground, body: Center(child: ElevatedButton(onPressed: () {
      context.read<AuthBloc>().add(SignOutEvent());
      context.go("/signIn");
    }, child: Text("Log Out"),)),),);
  }
}