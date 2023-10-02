import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

showSnackBarError(BuildContext context, String text) {
  AnimatedSnackBar.material(
    duration: const Duration(seconds: 1),
    text,
    type: AnimatedSnackBarType.error,
    mobilePositionSettings: const MobilePositionSettings(
      topOnAppearance: 75,
    ),
  ).show(context);
}

showSnackBarInfo(BuildContext context, String text) {
  AnimatedSnackBar.material(
    duration: const Duration(seconds: 1),
    text,
    type: AnimatedSnackBarType.info,
    mobilePositionSettings: const MobilePositionSettings(
      topOnAppearance: 75,
    ),
  ).show(context);
}

showSnackBarSuccess(BuildContext context, String text) {
  AnimatedSnackBar.material(
    duration: const Duration(seconds: 1),
    text,
    type: AnimatedSnackBarType.success,
    mobilePositionSettings: const MobilePositionSettings(
      topOnAppearance: 75,
    ),
  ).show(context);
}