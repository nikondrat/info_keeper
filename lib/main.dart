import 'dart:convert';
import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/data_init.dart';
import 'package:info_keeper/model/notification_init.dart';
import 'package:info_keeper/pages/home_page/home_page.dart';
import 'package:info_keeper/theme.dart';
import 'model/controller.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(Controller());
  // await clearData();
  await initData();
  await notificationInit();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
        initTheme: theme,
        builder: (context, myTheme) => GetMaterialApp(
              defaultTransition: Transition.cupertino,
              debugShowCheckedModeBanner: false,
              home: const HomePage(),
              theme: myTheme,
            ));
  }
}
