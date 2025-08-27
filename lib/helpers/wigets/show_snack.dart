import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/helpers/theme/app_colors.dart';
import 'package:weather_app/helpers/wigets/custom_text.dart';

class ShowSnack {
  static showSnack(BuildContext c, String message) {
    ScaffoldMessenger.of(c).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 500),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsetsGeometry.all(10),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.textPrimary, width: 1.2),
        ),
        backgroundColor: Theme.of(c).primaryColor,
        content: Center(
          child: CustomText(text: message, weight: FontWeight.w700, size: 14),
        ),
      ),
    );
  }
}
