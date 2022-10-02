import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData defaultDark = ThemeData(appBarTheme: appBarTheme);

AppBarTheme appBarTheme = const AppBarTheme(
    elevation: 1,
    shadowColor: Colors.grey,
    centerTitle: true,
    backgroundColor: Color(0xFF232527),
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent));
