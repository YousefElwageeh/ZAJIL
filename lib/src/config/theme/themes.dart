// ignore_for_file: deprecated_member_use

import 'package:call_service/src/config/theme/colorManger.dart';
import 'package:call_service/src/config/theme/font_manager.dart';
import 'package:call_service/src/config/theme/hexcolor.dart';
import 'package:call_service/src/config/theme/styles.dart';
import 'package:call_service/src/config/theme/valuseManger.dart';
import 'package:call_service/src/config/utils/AppStrings.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: AppStrings.fontFamily,
      appBarTheme: AppBarTheme(
          backgroundColor: HexColor("FFFFFF"),
          foregroundColor: HexColor("FFFFFF"),
          surfaceTintColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black)),
      popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
      iconTheme: const IconThemeData(color: Color(0xff2b2b2b)),
      primaryColor: ColorManager.primaryColor,
      splashColor: Colors.white.withOpacity(0.1),
      hoverColor: Colors.white,
      primaryColorDark: ColorManager.scaffoldBackgroundColorDark,
      splashFactory: InkRipple.splashFactory,
      highlightColor: Colors.transparent,
      canvasColor: Colors.white,
      scaffoldBackgroundColor: HexColor("FFFFFF"),

      cardColor: Colors.white,
      //   buttonColor: Color(primaryColor),
      textTheme: textTheme(ColorManager.scaffoldBackgroundColorDark),
      primaryTextTheme: textTheme(ColorManager.scaffoldBackgroundColorDark),
      platform: TargetPlatform.iOS,
      shadowColor: Colors.black,
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
              iconColor: MaterialStatePropertyAll(ColorManager.primaryColor))),
      indicatorColor: ColorManager.primaryColor,
      disabledColor: Colors.black.withOpacity(0.1),

      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle:
                  getRegularStyle(color: Colors.white, fontSize: FontSize.s17),
              backgroundColor: ColorManager.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)))),
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: HexColor('F7F8F9'),
          // content padding
          contentPadding: const EdgeInsets.all(AppPadding.p8),

          // hint style
          hintStyle: getRegularStyle(
              color: HexColor('8391A1'), fontSize: FontSize.s12),
          labelStyle: getRegularStyle(
              color: HexColor('8391A1'), fontSize: FontSize.s12),
          floatingLabelStyle: getRegularStyle(
              color: HexColor('8391A1'), fontSize: FontSize.s12),
          errorStyle: getRegularStyle(color: ColorManager.error),
          suffixIconColor: HexColor('6A707C'),
          prefixIconColor: HexColor('6A707C'),
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Colors.transparent, width: AppSize.s1_5),
              borderRadius: BorderRadius.circular(AppSize.s8)),
          // enabled border style
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: HexColor('E8ECF4'), width: AppSize.s1_5),
              borderRadius: BorderRadius.circular(AppSize.s8)),
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: HexColor('E8ECF4'), width: AppSize.s1_5),
              borderRadius: BorderRadius.circular(8)),
          // focused border style
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.primaryColor, width: AppSize.s1_5),
              borderRadius: BorderRadius.circular(AppSize.s8)),

          // error border style
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.error, width: AppSize.s1_5),
              borderRadius: BorderRadius.circular(AppSize.s8)),
          // focused border style
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.primaryColor, width: AppSize.s1_5),
              borderRadius: BorderRadius.circular(AppSize.s8))),

      // label style
    );
  }

  static TextTheme textTheme(Color textColor) {
    return TextTheme(
      displayLarge: getLargStyle(color: textColor, fontSize: FontSize.s22),
      headlineLarge: getSemiBoldStyle(color: textColor, fontSize: FontSize.s16),
      headlineMedium: getRegularStyle(color: textColor, fontSize: FontSize.s14),
      titleMedium: getMediumStyle(color: textColor, fontSize: FontSize.s16),
      bodyLarge: getLargStyle(color: textColor),
      bodySmall: getRegularStyle(color: textColor),
      bodyMedium: getRegularStyle(color: textColor),
    );
  }
}
