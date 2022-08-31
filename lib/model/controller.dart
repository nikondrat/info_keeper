import 'dart:convert';

import 'package:get/get.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/folder.dart';
import 'package:info_keeper/model/types/home/chat/old_chat.dart';
import 'package:info_keeper/model/types/home/chat/chat_file.dart';
import 'package:info_keeper/model/types/home/chat/chat_image.dart';
import 'package:info_keeper/model/types/home/chat/message.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/home/storage_file/storage_file.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller extends GetxController {
  static Controller get to => Get.find();

  var selectedElementIndex = 0.obs;
  var selectedFolder = 0.obs;

  int firstSelectedMessage = -1;

  var password = ''.obs;

  RxList<Folder> all = [
    Folder(name: 'Main screen', childrens: <HomeItem>[].obs),
  ].obs;

  RxList trashElements = [].obs;

  void setData() async {
    final prefs = await SharedPreferences.getInstance();

    // print(jsonEncode(all));

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

  void change(dynamic value) {
    HomeItem homeItem =
        HomeItem(child: StorageFile().obs, location: value.location);

    chat() {
      ChatItem chat = ChatItem();
      chat.messages = value.messages ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .child
              .value
              .messages;
      chat.favorites = value.favorites ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .child
              .value
              .favorites;
      chat.pathToImage = value.pathToImage ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .child
              .value
              .pathToImage;
      chat.pinnedMessages = value.pinnedMessages ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .child
              .value
              .pinnedMessages;

      homeItem.child = chat.obs;
      all[selectedFolder.value].childrens[selectedElementIndex.value] =
          homeItem;
    }

    storageFile() {
      StorageFile storageFile = StorageFile();
      storageFile.data = value.data ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .child
              .value
              .data;
      storageFile.history = value.history ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .child
              .value
              .history;
      storageFile.pathToImage = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .child
          .value
          .pathToImage;

      homeItem.child = storageFile.obs;

      all[selectedFolder.value].childrens[selectedElementIndex.value] =
          homeItem;
    }

    // todo() {
    //   Todo todo = Todo();
    //   todo.location = value.location ??
    //       all[selectedFolder.value]
    //           .childrens[selectedElementIndex.value]
    //           .location;
    //   todo.name = value.name ??
    //       all[selectedFolder.value].childrens[selectedElementIndex.value].name;
    //   todo.tasks = value.tasks ??
    //       all[selectedFolder.value].childrens[selectedElementIndex.value].tasks;
    //   todo.isAnimated = all[selectedFolder.value]
    //       .childrens[selectedElementIndex.value]
    //       .isAnimated;
    //   todo.dublicated = all[selectedFolder.value]
    //       .childrens[selectedElementIndex.value]
    //       .dublicated;
    //   todo.isPinned = all[selectedFolder.value]
    //       .childrens[selectedElementIndex.value]
    //       .isPinned;
    //   todo.isLocked = all[selectedFolder.value]
    //       .childrens[selectedElementIndex.value]
    //       .isLocked;
    //   todo.link =
    //       all[selectedFolder.value].childrens[selectedElementIndex.value].link;

    //   all[selectedFolder.value].childrens[selectedElementIndex.value] = todo;
    // }

    // audioNote() {
    //   AudioNote audioNote = AudioNote();
    //   audioNote.location = value.location ??
    //       all[selectedFolder.value]
    //           .childrens[selectedElementIndex.value]
    //           .location;
    //   audioNote.name = value.name ??
    //       all[selectedFolder.value].childrens[selectedElementIndex.value].name;
    //   audioNote.path = value.path ??
    //       all[selectedFolder.value].childrens[selectedElementIndex.value].path;
    //   audioNote.dublicated = all[selectedFolder.value]
    //       .childrens[selectedElementIndex.value]
    //       .dublicated;
    //   audioNote.isAnimated = all[selectedFolder.value]
    //       .childrens[selectedElementIndex.value]
    //       .isAnimated;
    //   audioNote.isLocked = all[selectedFolder.value]
    //       .childrens[selectedElementIndex.value]
    //       .isLocked;
    //   audioNote.isPinned = all[selectedFolder.value]
    //       .childrens[selectedElementIndex.value]
    //       .isPinned;
    //   audioNote.link =
    //       all[selectedFolder.value].childrens[selectedElementIndex.value].link;

    //   all[selectedFolder.value].childrens[selectedElementIndex.value] =
    //       audioNote;
    // }

    switch (value.child.type) {
      case AllType.chat:
        chat();
        break;
      case AllType.storageFile:
        storageFile();
        break;
      case AllType.todo:
        // todo();
        break;
      case AllType.audioNote:
        // audioNote();
        break;
      default:
    }
    setData();
  }

  void addLink(dynamic value, int folderIndex) {
    HomeItem homeItem =
        HomeItem(child: StorageFile().obs, location: value.location);

    chat() {
      ChatItem chat = ChatItem();
      chat.messages = value.messages ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .child
              .value
              .messages;
      chat.favorites = value.favorites ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .child
              .value
              .favorites;
      chat.pathToImage = value.pathToImage ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .child
              .value
              .pathToImage;
      chat.pinnedMessages = value.pinnedMessages ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .child
              .value
              .pinnedMessages;

      homeItem.child = chat.obs;
      homeItem.isLink = true;

      all[folderIndex].childrens.add(homeItem);
    }

    storageFile() {
      StorageFile storageFile = StorageFile();

      storageFile.data = value.data ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .child
              .value
              .data;
      storageFile.history = value.history ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .child
              .value
              .history;
      storageFile.pathToImage = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .child
          .value
          .pathToImage;

      homeItem.child = storageFile.obs;
      homeItem.isLink = true;

      all[folderIndex].childrens.add(homeItem);
    }

    // todo() {
    //   Todo todo = Todo();
    //   todo.location = value.location ??
    //       all[selectedFolder.value]
    //           .childrens[selectedElementIndex.value]
    //           .location;
    //   todo.name = value.name ??
    //       all[selectedFolder.value].childrens[selectedElementIndex.value].name;
    //   todo.tasks = value.tasks ??
    //       all[selectedFolder.value].childrens[selectedElementIndex.value].tasks;
    //   todo.isAnimated = all[selectedFolder.value]
    //       .childrens[selectedElementIndex.value]
    //       .isAnimated;
    //   todo.dublicated = all[selectedFolder.value]
    //       .childrens[selectedElementIndex.value]
    //       .dublicated;
    //   todo.isPinned = all[selectedFolder.value]
    //       .childrens[selectedElementIndex.value]
    //       .isPinned;
    //   todo.isLocked = all[selectedFolder.value]
    //       .childrens[selectedElementIndex.value]
    //       .isLocked;
    //   todo.link = true;
    //   all[folderIndex].childrens.add(todo);
    // }

    // audioNote() {
    //   AudioNote audioNote = AudioNote();
    //   audioNote.location = value.location ??
    //       all[selectedFolder.value]
    //           .childrens[selectedElementIndex.value]
    //           .location;
    //   audioNote.name = value.name ??
    //       all[selectedFolder.value].childrens[selectedElementIndex.value].name;
    //   audioNote.path = value.path ??
    //       all[selectedFolder.value].childrens[selectedElementIndex.value].path;
    //   audioNote.dublicated = all[selectedFolder.value]
    //       .childrens[selectedElementIndex.value]
    //       .dublicated;
    //   audioNote.isAnimated = all[selectedFolder.value]
    //       .childrens[selectedElementIndex.value]
    //       .isAnimated;
    //   audioNote.isLocked = all[selectedFolder.value]
    //       .childrens[selectedElementIndex.value]
    //       .isLocked;
    //   audioNote.isPinned = all[selectedFolder.value]
    //       .childrens[selectedElementIndex.value]
    //       .isPinned;
    //   audioNote.link = true;

    //   all[folderIndex].childrens.add(audioNote);
    // }

    switch (value.child.type) {
      case AllType.chat:
        chat();
        break;
      case AllType.storageFile:
        storageFile();
        break;
      case AllType.todo:
        // todo();
        break;
      case AllType.audioNote:
        // audioNote();
        break;
      default:
    }
    setData();
  }

  void addMessage(OldMessage message) {
    all[selectedFolder.value]
        .childrens[selectedElementIndex.value]
        .child
        .value
        .messages
        .insert(0, message);
    setData();
  }

  void addChatImage(OldChatImage image) {
    all[selectedFolder.value]
        .childrens[selectedElementIndex.value]
        .child
        .value
        .messages
        .insert(0, image);
    setData();
  }

  void addChatFile(OldChatFile file) {
    all[selectedFolder.value]
        .childrens[selectedElementIndex.value]
        .child
        .value
        .messages
        .insert(0, file);
    setData();
  }
}
