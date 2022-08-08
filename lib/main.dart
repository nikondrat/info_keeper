// import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/data_init.dart';
import 'package:info_keeper/model/notification_init.dart';
import 'package:info_keeper/pages/home_page/home_page.dart';
import 'package:info_keeper/theme.dart';
import 'model/controller.dart';
// import 'package:http/http.dart' as http;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(Controller());
  // await clearData();
  await initData();
  await notificationInit();

  // final response = await http.get(Uri.parse(
  //     'https://e1.pcloud.link/publink/show?code=XZtFvLZvxk9ASL30Xkx6qI5bcF1bX8qsdNV'));

  // print(utf8.encode(response.body));

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
