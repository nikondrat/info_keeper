import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData defaultLight = ThemeData(appBarTheme: _appBarTheme);

AppBarTheme _appBarTheme = const AppBarTheme(
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
