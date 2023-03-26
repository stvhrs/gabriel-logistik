import 'package:flutter/material.dart';

class AppTheme {
  AppTheme();
  static Color primaryColor = const Color.fromARGB(255, 59, 59, 65);
  static Color secondaryColor =primaryColor.withBlue(150);
  static ThemeData getAppThemeData() {
    return ThemeData(iconTheme: const IconThemeData(size: 19),
        fontFamily: 'FreeSans',cardTheme: CardTheme(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        useMaterial3: true,backgroundColor: Colors.grey.shade300,
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
        scaffoldBackgroundColor: Colors.grey.shade300,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                textStyle: MaterialStateProperty.all(
                     const TextStyle(color: Colors.white,fontFamily: 'Nunito')),
                backgroundColor: MaterialStateProperty.all(Colors.green.shade500  ))),
        primaryColor: primaryColor,
     
        scrollbarTheme: const ScrollbarThemeData()
            .copyWith(thumbColor: MaterialStateProperty.all(secondaryColor)),
        textTheme: const TextTheme(
            displaySmall: TextStyle(
              fontSize: 13,
              color: Colors.black,fontFamily: 'FreeSans'
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
              letterSpacing: 1,fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
              fontSize: 18, color: Colors.grey.shade600, letterSpacing: 0.7),
          contentPadding: const EdgeInsets.only(left: 10, top: 0, bottom: 0),
          filled: true,
          fillColor: Colors.grey.shade200,
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
