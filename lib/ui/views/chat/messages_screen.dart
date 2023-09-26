import 'package:chat_connect/resources/resources.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375.w,
      height: 812.h,
      child: Scaffold(
        backgroundColor: ColorProvider.secondaryBackground,
        body: SafeArea(
          child: Column(
            children: [
              reusableAppBar("Martyna Pietranik"),
              Expanded(
                child: Container(
                  width: 375.w,
                  margin: EdgeInsets.only(top: 50.h),
                  decoration: const BoxDecoration(
                    color: ColorProvider.mainBackground,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                  ),
                  child: Column(children: [
                    Container(
                      width: 100.w,
                      height: 30.h,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: ColorProvider.secondaryBackground,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: reusableMessageText("Today", fontSize: 14),
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
