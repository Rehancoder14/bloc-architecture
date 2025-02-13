import 'package:blogclean/core/theme/app_palete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(
        27,
      ),
      enabledBorder: _outlineInputBorder(),
      errorBorder: _outlineInputBorder(Colors.red),
      focusedBorder: _outlineInputBorder(AppPallete.gradient2),
    ),
  );

  static OutlineInputBorder _outlineInputBorder([
    Color color = AppPallete.borderColor,
  ]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        10,
      ),
      borderSide: BorderSide(
        color: color,
        width: 3,
      ),
    );
  }
}
