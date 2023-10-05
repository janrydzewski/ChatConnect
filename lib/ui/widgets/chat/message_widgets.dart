import 'package:chat_connect/resources/resources.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

reusableMessageWidget(String text, bool amISender) {
  return Container(
    width: 200.w,
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
    child: reusableChatText(text,
        fontSize: 12,
        fontColor:
            amISender ? ColorProvider.mainBackground : ColorProvider.mainText),
  );
}

reusableMessageTextField(TextEditingController textEditingController) {
  return Container(
    width: 310.w,
    height: 50.h,
    margin: EdgeInsets.only(top: 5.h),
    padding: EdgeInsets.symmetric(horizontal: 15.w),
    child: TextFormField(
      controller: textEditingController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          iconColor: ColorProvider.mainText,
          hintText: "Message..."),
      style: GoogleFonts.montserrat(fontSize: 15.sp),
      autocorrect: false,
    ),
  );
}

reusableMessageAppBar(String text, BuildContext context) {
  return AppBar(
    backgroundColor: ColorProvider.secondaryBackground,
    shadowColor: Colors.transparent,
    title: reusableMessageText(text),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: ColorProvider.mainText),
      onPressed: () {
        context.go("/chat");
      },
    ),
  );
}
