import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/core/resource/app_colors.dart';
import 'package:test_project/core/resource/app_functions.dart';
import 'package:test_project/core/resource/app_values.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.inactiveColor,
    primarySwatch: getMaterialColor(AppColors.primarySwatchColor),
    splashColor: AppColors.transparent,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: _getTextStyle(
        fontSize: AppSize.s18,
        color: AppColors.black,
      ),
    ),

    // text theme
    textTheme: TextTheme(
      titleMedium: _getTextStyle(
          fontSize: AppSize.s18,
          color: AppColors.color292929,
          fontWeight: FontWeight.w700),
      titleLarge: _getTextStyle(
          fontSize: AppSize.s20,
          color: AppColors.color292929,
          fontWeight: FontWeight.w700),
      titleSmall: _getTextStyle(
        fontSize: AppSize.s16,
        color: AppColors.color292929,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: _getTextStyle(
        fontSize: AppSize.s15,
        fontWeight: FontWeight.w400,
        color: AppColors.color292929,
      ),
      bodyMedium: _getTextStyle(
        fontSize: AppSize.s12,
        color: AppColors.color292929,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: _getTextStyle(
        fontSize: AppSize.s12,
        fontWeight: FontWeight.w400,
        color: AppColors.color292929,
      ),
    ),
  );
}

TextStyle _getTextStyle({
  required double fontSize,
  FontWeight fontWeight = FontWeight.w600,
  required Color color,
}) {
  return GoogleFonts.mavenPro(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}
