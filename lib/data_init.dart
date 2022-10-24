import 'dart:convert';

import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/folder.dart';
// import 'package:info_keeper/model/types/all.dart';
// import 'package:info_keeper/model/types/home/audio/audio_note.dart';
// import 'package:info_keeper/model/types/home/chat/chat.dart';
// import 'package:info_keeper/model/types/home/chat/chat_file.dart';
// import 'package:info_keeper/model/types/home/chat/chat_image.dart';
// import 'package:info_keeper/model/types/home/chat/chat_voice.dart';
// import 'package:info_keeper/model/types/home/chat/message.dart';
// import 'package:info_keeper/model/types/home/storage_file/storage_file.dart';
// import 'package:info_keeper/model/types/home/todo/todo.dart';
import 'package:info_keeper/model/types/trash/trash_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

initData() async {
  final prefs = await SharedPreferences.getInstance();

  if (prefs.getString('all') == null) {
    prefs.setString('all', '');
  } else {
    if (prefs.getString('all')!.isNotEmpty) {
      String stringData = prefs.getString('all')!;
      Iterable data = jsonDecode(stringData);
      List<Folder> folders = List.from(data.map((e) => Folder.fromJson(e)));

      Controller.to.all = folders.obs;
    }
  }
  if (prefs.getBool('isDark') == null) {
    prefs.setBool('isDark', false);
  } else {
    Controller.to.isDark = prefs.getBool('isDark')!;
  }
  if (prefs.getString('trash') == null) {
    prefs.setString('trash', '');
  } else {
    if (prefs.getString('trash')!.isNotEmpty) {
      String stringData = prefs.getString('trash')!;
      Iterable data = jsonDecode(stringData);
      List<TrashItem> items = List.from(data.map((e) => TrashItem.fromJson(e)));
      // List items = List.from(data
      //     .map((e) {
      //       switch (AllType.values.elementAt(e['type'])) {
      //         case AllType.chat:
      //           return Chat.fromJson(e);
      //         case AllType.storageFile:
      //           return StorageFile.fromJson(e);
      //         case AllType.todo:
      //           return Todo.fromJson(e);
      //         case AllType.audioNote:
      //           return AudioNote.fromJson(e);
      //         case AllType.chatMessage:
      //           return Message.fromJson(e);
      //         case AllType.chatFile:
      //           return ChatFile.fromJson(e);
      //         case AllType.chatVoice:
      //           return ChatVoice.fromJson(e);
      //         case AllType.chatImage:
      //           return ChatImage.fromJson(e);
      //       }
      //     })
      //     .toList()
      //     .obs);

      Controller.to.trashElements = items.obs;
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
  prefs.setString('trash', '');
}
