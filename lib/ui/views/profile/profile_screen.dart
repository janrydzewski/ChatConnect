import 'package:chat_connect/bloc/bloc.dart';
import 'package:chat_connect/resources/resources.dart';
import 'package:chat_connect/ui/ui.dart';
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
        backgroundColor: ColorProvider.mainBackground,
        body: SafeArea(
          child: BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserError) {
                print(state.message);
              }
            },
            builder: (context, state) {
              if (state is UserLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.userModel.id.isNotEmpty) {
                return Column(
                  children: [
                    Container(
                      width: 375.w,
                      height: 35.h,
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search_outlined,
                          size: 35.w,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 25.w),
                      child: reusableText("Chat", fontSize: 34),
                    ),
                    Expanded(
                      child: Container(
                        width: 375.w,
                        margin: EdgeInsets.only(
                            left: 30.w, right: 30.w, top: 50.h, bottom: 50.h),
                        decoration: BoxDecoration(
                          color: ColorProvider.secondaryBackground,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: ColorProvider.mainBackground
                                      .withOpacity(0.5)),
                              child: Icon(
                                Icons.person,
                                size: 100.w,
                              ),
                            ),
                            reusableProfileText(
                                "${state.userModel.firstName} ${state.userModel.lastName}"),
                            Column(
                              children: [
                                reusableProfileButton("Edit Profile", () {}),
                                reusableProfileButton("Log Out", () {
                                  context.read<AuthBloc>().add(SignOutEvent());
                                  context.go('/signIn');
                                }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
