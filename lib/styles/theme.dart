import 'package:flutter/material.dart';

class AppTheme {
  AppTheme();
  static Color primaryColor = Color.fromARGB(255, 163, 213, 237);
  static Color secondaryColor = Colors.yellow.shade200;
  static ThemeData getAppThemeData() {
    return ThemeData(
      scrollbarTheme: const ScrollbarThemeData()
          .copyWith(thumbColor: MaterialStateProperty.all(secondaryColor)),
      textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          headline2: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
      inputDecorationTheme: InputDecorationTheme(
        //        border: InputBorder.none,

        contentPadding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
        filled: true, //<-- SEE HERE
        fillColor: Colors.grey.shade200,

        hintStyle: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 14,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(primary: primaryColor, secondary: secondaryColor),
    );
  }
}
