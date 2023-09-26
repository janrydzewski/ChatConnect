import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/resources/resources.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

reusableMainMessageWidget({required MessageModel messageModel}) {
  return Container(
    width: 375.w,
    height: 85.h,
    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
    child: Row(
      children: [
        Container(
          width: 75.w,
          height: 75.w,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: ColorProvider.fourthText),
          child: Icon(
            Icons.person,
            size: 65.w,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: reusableMessageText(messageModel.sender,
                      fontSize: 20, fontColor: ColorProvider.thirdText),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: reusableMessageText(
                    messageModel.message,
                    maxLines: 2,
                    fontSize: 13,
                    fontColor: ColorProvider.fourthText,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 65.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              reusableMessageText(
                  "${DateTime.now().difference(messageModel.date).inMinutes} minutes",
                  fontSize: 13),
              Container(
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
                alignment: Alignment.center,
                child: reusableMessageText("1", fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

reusableAppBar(String text) {
  return AppBar(
    backgroundColor: ColorProvider.secondaryBackground,
    shadowColor: Colors.transparent,
    title: reusableMessageText(text),
    iconTheme: const IconThemeData(color: ColorProvider.mainText),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.info_outline),
      ),
    ],
  );
}
