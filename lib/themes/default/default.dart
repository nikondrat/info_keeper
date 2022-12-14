import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData defaultLight = ThemeData(
    inputDecorationTheme: inputDecorationTheme,
    primaryColor: Colors.black,
    canvasColor: Colors.white,
    appBarTheme: appBarTheme,
    textButtonTheme: textButtonTheme,
    checkboxTheme: checkboxTheme,
    bottomAppBarTheme: bottomAppBarTheme,
    floatingActionButtonTheme: floatingActionButtonThemeData);

AppBarTheme appBarTheme = const AppBarTheme(
    elevation: 1,
    centerTitle: true,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent));

InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.red)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)));

BottomAppBarTheme bottomAppBarTheme =
    const BottomAppBarTheme(color: Colors.white);

TextButtonThemeData textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.black),
        overlayColor: MaterialStateProperty.all(
            Platform.isAndroid || Platform.isIOS
                ? Colors.grey.shade200
                : Colors.grey.shade300),
        splashFactory: NoSplash.splashFactory));

CheckboxThemeData checkboxTheme = CheckboxThemeData(
    fillColor: MaterialStateProperty.all(Colors.grey.shade600),
    overlayColor: MaterialStateProperty.all(Colors.transparent));

FloatingActionButtonThemeData floatingActionButtonThemeData =
    FloatingActionButtonThemeData(
        elevation: 0,
        disabledElevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: CircleBorder(
            side: BorderSide(
                color: Platform.isAndroid || Platform.isIOS
                    ? Colors.grey.shade300
                    : Colors.black54)));

int defaultColor = 5;

List messageColors = const [
  Color(0xFFC9FEF8),
  Color(0xFFB18CFE),
  Color(0xFFEE719E),
  Color(0xFF02D8FF),
  Color(0xFFD8C9FE),
  Color(0xFFBDEE81),
  Color(0xFFFFAB01),
  Color(0xFFFF8C82),
  Color(0xFF49FF02),
  Color(0xFFF6FF02),
  Color(0xFFEFFDDE),
  Color(0xFFBDC0C0),
];
