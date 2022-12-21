import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/folder.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/storage_file/storage_file.dart';
import 'package:info_keeper/model/types/home/task/task.dart';
import 'package:info_keeper/model/types/home/task/todo.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/item_location.dart';
import 'package:info_keeper/model/types/trash/trash_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller extends GetxController {
  static Controller get to => Get.find();

  var selectedElementIndex = 0.obs;
  var selectedFolder = 0.obs;
  bool isDark =
      WidgetsBinding.instance.window.platformBrightness == Brightness.dark;

  int firstSelectedMessage = -1;

  var password = ''.obs;

  RxList<Folder> all =
      <Folder>[Folder(name: 'Main screen', childrens: <HomeItem>[].obs)].obs;

  RxList<TrashItem> trashElements = <TrashItem>[].obs;

  void setData() async {
    final prefs = await SharedPreferences.getInstance();

    // print(jsonEncode(all));

    await prefs.setBool('isDark', isDark);
    await prefs.setString('all', jsonEncode(all));
    await prefs.setString('trash', jsonEncode(trashElements));
    await prefs.setString('password', password.value);
  }

  void add(value) {
    all[selectedFolder.value].childrens.add(value);
    setData();
  }

  delete(value) {
    all[selectedFolder.value].childrens.remove(value);
    trashElements.add(value);
    setData();
  }
}
