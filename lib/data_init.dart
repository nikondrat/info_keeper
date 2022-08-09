import 'dart:convert';

import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/folder.dart';
import 'package:shared_preferences/shared_preferences.dart';

initData() async {
  final prefs = await SharedPreferences.getInstance();

  if (prefs.getString('all') == null) {
    prefs.setString('all', '');
  } else {
    if (prefs.getString('all')!.isNotEmpty) {
      String stringData = prefs.getString('all')!;
      Iterable data = jsonDecode(stringData);
      List items = List.from(data.map((e) => Folder.fromJson(e)));

      Controller.to.all = items.obs;
    }
  }
  if (prefs.getString('password') == null) {
    prefs.setString('password', '');
  } else {
    Controller.to.password = prefs.getString('password')!.obs;
  }
}

clearData() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('all', '');
  prefs.setString('password', '');
}
