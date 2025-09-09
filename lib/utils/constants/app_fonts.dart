import 'package:flutter/material.dart';

class AppFonts {
  static const String playfairDisplay = 'PlayfairDisplay';
  static const String roboto = 'Roboto';

  /// PlayfairDisplay font styles
  static TextStyle playfairDisplayStyle({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
    FontStyle? fontStyle,
  }) {
    return TextStyle(
      fontFamily: playfairDisplay,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontStyle: fontStyle,
    );
  }

  /// Roboto font styles
  static TextStyle robotoStyle({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
    FontStyle? fontStyle,
  }) {
    return TextStyle(
      fontFamily: roboto,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontStyle: fontStyle,
    );
  }
}