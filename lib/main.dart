import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:info_keeper/app/providers/home_provider.dart';
import 'package:info_keeper/app/views/home_view.dart';
import 'package:info_keeper/data_init.dart';
import 'package:info_keeper/generated/l10n.dart';
import 'package:info_keeper/pages/home_page/home_page.dart';
import 'package:info_keeper/themes/default/default.dart';
import 'package:info_keeper/themes/default/default_dark.dart';
import 'package:provider/provider.dart';
import 'model/controller.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(Controller());

  // await clearData();
  await initData();
  // if (Platform.isAndroid || Platform.isIOS) {
  //   await notificationInit();
  //   await Firebase.initializeApp(
  //       options: DefaultFirebaseOptions.currentPlatform);
  // }

  runApp(MultiProvider(providers: [
    ListenableProvider<HomeProvider>(
        create: (context) => HomeProvider(),
        dispose: (context, value) => value.dispose())
  ], child: const MyApp()));
}

// Future<String> getData() async {
//   CollectionReference collectionRef =
//       FirebaseFirestore.instance.collection('paid');
//   // Get docs from collection reference
//   QuerySnapshot querySnapshot = await collectionRef.get();

//   // Get data from docs and convert map to List
//   final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

//   return allData.first.toString();
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initTheme = Controller.to.isDark ? defaultDark : defaultLight;

    return ThemeProvider(
        initTheme: initTheme,
        builder: (context, myTheme) => MaterialApp(
              debugShowCheckedModeBanner: false,
              home: const HomeView(),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              // Platform.isAndroid || Platform.isIOS
              //     ? FutureBuilder<String>(
              //         future: getData(),
              //         builder: (context, AsyncSnapshot<String> snapshot) {
              //           if (snapshot.hasData) {
              //             return snapshot.data! == '{paid: true}'
              //                 ? const HomePage()
              //                 : const Scaffold(
              //                     body: Center(
              //                         child: Text('Приложение не оплачено')),
              //                   );
              //           }
              //           return const Scaffold();
              //         })
              //     :
              theme: myTheme,
            ));
  }
}
