import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/data_init.dart';
import 'package:info_keeper/firebase_options.dart';
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

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('paid');

Future<String> getData() async {
  // Get docs from collection reference
  QuerySnapshot querySnapshot = await _collectionRef.get();

  // Get data from docs and convert map to List
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

  return allData.first.toString();
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
              home: FutureBuilder<String>(
                  future: getData(),
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data! == '{paid: true}'
                          ? const HomePage()
                          : const Scaffold(
                              body:
                                  Center(child: Text('Приложение не оплачено')),
                            );
                    }
                    return const Scaffold();
                  }),
              theme: myTheme,
            ));
  }
}
