import 'package:chat_connect/resources/resources.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

reusableProfileText(String text) {
  return Container(
    width: 375.w,
    height: 60.h,
    alignment: Alignment.center,
    child: reusableText(text, fontSize: 30),
  );
}

reusableProfileButton(String text, Function() func) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: 310.w,
      height: 50.h,
      margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorProvider.mainBackground.withOpacity(0.5)),
      child: reusableText(text,
          fontSize: 16, fontColor: ColorProvider.secondaryText),
    ),
  );
}

reusableProfileSecondaryButton(String text, Function() func) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: 310.w,
      height: 50.h,
      margin: EdgeInsets.symmetric(horizontal: 70.w, vertical: 10.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorProvider.secondaryElement),
      child: reusableText(text,
          fontSize: 16, fontColor: ColorProvider.secondaryText),
    ),
  );
}
