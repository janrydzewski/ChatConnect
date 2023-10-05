import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/resources/resources.dart';
import 'package:chat_connect/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

reusableSearchBarWidget(
    TextEditingController textEditingController, Function() func) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 35.w),
    width: 375.w,
    height: 60.h,
    child: TextField(
      controller: textEditingController,
      style: GoogleFonts.archivo(
        fontWeight: FontWeight.w500,
        color: ColorProvider.mainText,
        fontSize: 18.sp,
      ),
      cursorColor: ColorProvider.mainText,
      decoration: InputDecoration(
          hoverColor: ColorProvider.mainText,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: ColorProvider.mainText,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: ColorProvider.mainText,
            ),
          ),
          border: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: func,
            child: Icon(
              Icons.search_outlined,
              size: 30.h,
              color: ColorProvider.mainText,
            ),
          )),
    ),
  );
}

reusableUserModelElement(UserModel userModel) {
  return Container(
    width: 375.w,
    height: 100.h,
    margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 75.w,
          height: 75.w,
          margin: EdgeInsets.only(right: 15.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorProvider.secondaryBackground.withOpacity(0.8)),
          child: userModel.photoUrl.isNotEmpty
              ? SizedBox(
                  width: 65.w,
                  height: 65.w,
                  child: Image.network(
                    userModel.photoUrl,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return loadingWidget();
                    },
                  ),
                )
              : Icon(
                  Icons.person,
                  size: 65.w,
                ),
        ),
        Expanded(
          child: reusableMessageText(
              "${userModel.firstName} ${userModel.lastName}",
              fontSize: 16),
        ),
      ],
    ),
  );
}
