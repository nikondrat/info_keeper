import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/data_init.dart';
import 'package:info_keeper/firebase_options.dart';
import 'package:info_keeper/model/notification_init.dart';
import 'package:info_keeper/pages/home_page/home_page.dart';
import 'package:info_keeper/themes/default/default.dart';
import 'package:info_keeper/themes/default/default_dark.dart';
import 'model/controller.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(Controller());

  await clearData();
  await initData();
  if (Platform.isAndroid || Platform.isIOS) {
    await notificationInit();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  runApp(const MyApp());
}

Future<String> getData() async {
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('paid');
  // Get docs from collection reference
  QuerySnapshot querySnapshot = await collectionRef.get();

  // Get data from docs and convert map to List
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

  return allData.first.toString();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initTheme = Controller.to.isDark ? defaultDark : defaultLight;

    return ThemeProvider(
        initTheme: initTheme,
        builder: (context, myTheme) => GetMaterialApp(
              defaultTransition: Transition.cupertino,
              debugShowCheckedModeBanner: false,
              home: Platform.isAndroid || Platform.isIOS
                  ? FutureBuilder<String>(
                      future: getData(),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data! == '{paid: true}'
                              ? const HomePage()
                              : const Scaffold(
                                  body: Center(
                                      child: Text('Приложение не оплачено')),
                                );
                        }
                        return const Scaffold();
                      })
                  : const HomePage(),
              theme: myTheme,
            ));
  }
}
