import 'package:flutter/material.dart';

class AppTheme {
  AppTheme();
  static Color primaryColor = const Color.fromARGB(255, 75, 84, 167);
  static Color secondaryColor = const Color.fromARGB(255, 146, 154, 204);
  static ThemeData getAppThemeData() {
    return ThemeData(
        fontFamily: 'Nunito',
        useMaterial3: true,
        dialogBackgroundColor: Colors.white,
        dialogTheme: const DialogTheme(
          backgroundColor: Colors.white,
        ),
        chipTheme: ChipThemeData(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.red,
            disabledColor: Colors.greenAccent,
            elevation: 0,
            selectedColor: Colors.pink,
            checkmarkColor: Colors.green,
            showCheckmark: false,
            deleteIconColor: Colors.amber,
            secondarySelectedColor: primaryColor,
            shadowColor: Colors.yellow,
            selectedShadowColor: Colors.black),
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                textStyle:
                    MaterialStateProperty.all(const TextStyle(color: Colors.white)),
                backgroundColor: MaterialStateProperty.all(Colors.green))),
        primaryColor: primaryColor,
        buttonTheme: const ButtonThemeData(),
        scrollbarTheme: const ScrollbarThemeData()
            .copyWith(thumbColor: MaterialStateProperty.all(secondaryColor)),
        textTheme: const TextTheme(           displaySmall: TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
            bodyLarge: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            displayLarge: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            displayMedium: TextStyle(
              fontSize: 14,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
              fontSize: 18, color: Colors.grey.shade600, letterSpacing: 0.7),
          //        border: InputBorder.none,

          contentPadding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
          filled: true, //<-- SEE HERE
          fillColor: Colors.grey.shade200,

          // hintStyle: TextStyle(
          //   color: Colors.grey.shade600,
          //   fontSize: 14,
          // ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: primaryColor),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: primaryColor,
            secondary: secondaryColor,
            background: Colors.white));
  }
}
