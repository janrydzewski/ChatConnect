import 'package:chat_connect/resources/resources.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

reusableMessageWidget(String text, bool amISender) {
  return Container(
    width: 200.w,
    //height: 70.h,
    margin: EdgeInsets.only(
        top: 10.h,
        bottom: 10.h,
        left: amISender ? 150.w : 20.w,
        right: amISender ? 20.w : 150.w),
    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
      color: amISender ? ColorProvider.fromMessage : ColorProvider.toMessage,
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(35),
        topRight: const Radius.circular(35),
        bottomLeft:
            amISender ? const Radius.circular(35) : const Radius.circular(0),
        bottomRight:
            amISender ? const Radius.circular(0) : const Radius.circular(35),
      ),
    ),
    child: reusableChatText(text, fontSize: 12, fontColor: amISender ? ColorProvider.mainBackground : ColorProvider.mainText),
  );
}
