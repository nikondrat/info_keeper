import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color defaultBlackColor = const Color(0xFF232527);

ThemeData defaultDark = ThemeData(
    popupMenuTheme: popupMenuThemeData,
    dialogBackgroundColor: defaultBlackColor,
    inputDecorationTheme: inputDecorationTheme,
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: textTheme,
    primaryColor: Colors.white,
    textButtonTheme: textButtonTheme,
    canvasColor: defaultBlackColor,
    bottomAppBarTheme: bottomAppBarTheme,
    appBarTheme: appBarTheme,
    floatingActionButtonTheme: floatingActionButtonThemeData);

TextTheme textTheme = TextTheme(
    subtitle2: const TextStyle(color: Colors.white),
    bodyText2: const TextStyle(color: Colors.white),
    headline6: const TextStyle(color: Colors.white),
    headline5: const TextStyle(color: Colors.white),
    headline4: TextStyle(color: Colors.grey.shade400),
    subtitle1: const TextStyle(color: Colors.white));

PopupMenuThemeData popupMenuThemeData = PopupMenuThemeData(
    color: defaultBlackColor, shape: Border.all(color: Colors.white));

AppBarTheme appBarTheme = AppBarTheme(
    elevation: 1,
    shadowColor: Colors.grey,
    centerTitle: true,
    backgroundColor: defaultBlackColor,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: const TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
    systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent));

InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    hintStyle: const TextStyle(color: Colors.white),
    counterStyle: const TextStyle(color: Colors.white),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.red)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.white)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.white)),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.white)),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)));

BottomAppBarTheme bottomAppBarTheme =
    BottomAppBarTheme(color: defaultBlackColor);

TextButtonThemeData textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
        overlayColor: MaterialStateProperty.all(Colors.grey.shade700),
        splashFactory: NoSplash.splashFactory));

FloatingActionButtonThemeData floatingActionButtonThemeData =
    FloatingActionButtonThemeData(
        elevation: 0,
        disabledElevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        backgroundColor: defaultBlackColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Platform.isAndroid || Platform.isIOS
                    ? Colors.grey
                    : defaultBlackColor),
            borderRadius: BorderRadius.circular(50)));
