import 'package:call_service/src/config/theme/font_manager.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: FontConstants.fontFamily,
      color: color,
      fontWeight: fontWeight);
}

// regular style

TextStyle getRegularStyle(
    {double fontSize = FontSize.s12, Color color = Colors.black}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

// medium style

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, Color color = Colors.black}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

TextStyle getLargStyle(
    {double fontSize = FontSize.s30, Color color = Colors.black}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}

// medium style

TextStyle getLightStyle(
    {double fontSize = FontSize.s16, Color color = Colors.black}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}

// bold style

TextStyle getBoldStyle(
    {double fontSize = FontSize.s12, Color color = Colors.black}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}

// semibold style

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s14, Color color = Colors.black}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}
