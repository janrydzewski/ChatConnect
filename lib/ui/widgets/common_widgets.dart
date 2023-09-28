import 'package:chat_connect/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

reusableText(String text,
    {double fontSize = 24,
    Color fontColor = ColorProvider.mainText,
    FontWeight fontWeight = FontWeight.w600,
    double letterSpacing = 0,
    TextAlign textAlign = TextAlign.start, int maxLines = 1}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.robotoCondensed(
        fontSize: fontSize.sp,
        color: fontColor,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,),
  );
}

reusableMessageText(String text,
    {double fontSize = 24,
    Color fontColor = ColorProvider.mainText,
    FontWeight fontWeight = FontWeight.w600,
    double letterSpacing = 0,
    TextAlign textAlign = TextAlign.start, int maxLines = 1}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.inclusiveSans(
        fontSize: fontSize.sp,
        color: fontColor,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,),
  );
}

loadingWidget() {
  return const Center(child: CircularProgressIndicator(color: ColorProvider.mainText,),);
}
