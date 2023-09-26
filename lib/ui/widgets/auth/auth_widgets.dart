import 'package:chat_connect/resources/colors/colors.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

reusableAuthText(String text) {
  return Container(
    width: 375.w,
    height: 60.h,
    alignment: Alignment.center,
    margin: EdgeInsets.symmetric(vertical: 30.h),
    child: reusableText(text, fontSize: 30),
  );
}

reusableAuthChangeCardText(String text, Function() func) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: 375.w,
      height: 60.h,
      alignment: Alignment.center,
      
      child: reusableText(text, fontSize: 14),
    ),
  );
}

reusableAuthTextField(
    String text, TextEditingController textEditingController) {
  return Container(
    width: 310.w,
    height: 60.h,
    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
    padding: EdgeInsets.symmetric(horizontal: 15.w),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: ColorProvider.mainElement)),
    child: TextFormField(
      
      controller: textEditingController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        iconColor: ColorProvider.mainText,
        icon: Icon(text == "First Name"
            ? Icons.person
            : text == "Last Name"
                ? Icons.person
                : text == "Email"
                    ? Icons.email
                    : Icons.lock),
        hintText: text,
        hintStyle: GoogleFonts.robotoCondensed(fontSize: 14.sp),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (text == "Email") {
          return value != null && !EmailValidator.validate(value)
              ? "Enter a valid email"
              : null;
        } else if (text == "Password") {
          return value != null && value.length < 6
              ? "Enter min. 6 characters"
              : null;
        }
        return null;
      },
      autocorrect: false,
      obscureText: text == "Password" ? true : false,
    ),
  );
}

reusableAuthButton(String text, Function() func) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: 310.w,
      height: 50.h,
      margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorProvider.secondaryElement),
      child: reusableText(text,
          fontSize: 16, fontColor: ColorProvider.secondaryText),
    ),
  );
}
