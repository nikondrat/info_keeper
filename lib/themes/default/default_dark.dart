import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color defaultBlackColor = const Color(0xFF232527);

ThemeData defaultDark = ThemeData(
    popupMenuTheme: popupMenuThemeData,
    dialogBackgroundColor: defaultBlackColor,
    inputDecorationTheme: inputDecorationTheme,
    iconTheme: const IconThemeData(color: Colors.white),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
    textTheme: const TextTheme(
        headline6: TextStyle(color: Colors.white),
        subtitle1: TextStyle(color: Colors.white)),
    primaryColor: Colors.white,
    textButtonTheme: textButtonTheme,
    canvasColor: defaultBlackColor,
    bottomAppBarTheme: bottomAppBarTheme,
    appBarTheme: appBarTheme,
    floatingActionButtonTheme: floatingActionButtonThemeData);

PopupMenuThemeData popupMenuThemeData =
    PopupMenuThemeData(color: defaultBlackColor);

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
