import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData theme = ThemeData(
    appBarTheme: const AppBarTheme(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent)),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.black),
          overlayColor: MaterialStateProperty.all(Colors.grey.shade200),
          splashFactory: NoSplash.splashFactory),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0,
      disabledElevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(50)),
    ));

ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent)),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.black),
          overlayColor: MaterialStateProperty.all(Colors.grey.shade200),
          splashFactory: NoSplash.splashFactory),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0,
      disabledElevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(50)),
    ));

List messageColors = const [
  Color(0xFFC9FEF8),
  Color(0xFFB18CFE),
  Color(0xFFEE719E),
  Color.fromARGB(255, 126, 85, 223),
  Color(0xFFD8C9FE),
  Color(0xFFBDEE81),
  Color(0xFFFFAB01),
  Color(0xFFFF8C82),
  Color(0xFFFF4015),
  Color(0xFFFE6250),
  Color(0xFFEFFDDE),
  Color(0xFFBDC0C0),
];
