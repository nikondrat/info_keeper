import 'dart:convert';

import 'package:get/get.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/audio_note.dart';
import 'package:info_keeper/model/types/chat/chat.dart';
import 'package:info_keeper/model/types/chat/chat_file.dart';
import 'package:info_keeper/model/types/chat/chat_image.dart';
import 'package:info_keeper/model/types/chat/chat_voice.dart';
import 'package:info_keeper/model/types/folder.dart';
import 'package:info_keeper/model/types/chat/message.dart';
import 'package:info_keeper/model/types/storage_file.dart';
import 'package:info_keeper/model/types/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller extends GetxController {
  static Controller get to => Get.find();

  var selectedElementIndex = 0.obs;
  var selectedFolder = 0.obs;

  int firstSelectedMessage = -1;

  var password = ''.obs;

  RxList<Folder> all = [
    Folder(name: 'Main screen', childrens: [].obs),
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
    chat() {
      Chat chat = Chat();
      chat.location = value.location ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .location;
      chat.name = value.name ??
          all[selectedFolder.value].childrens[selectedElementIndex.value].name;
      chat.messages = value.messages ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .messages;
      chat.favorites = value.favorites ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .favorites;
      chat.isPinned = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .isPinned;
      chat.animate = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .animate;
      chat.dublicated = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .dublicated;
      chat.pathToImage = value.pathToImage ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .pathToImage;
      chat.link =
          all[selectedFolder.value].childrens[selectedElementIndex.value].link;
      chat.isLocked = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .isLocked;
      chat.pinnedMessages = value.pinnedMessages ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .pinnedMessages;

      all[selectedFolder.value].childrens[selectedElementIndex.value] = chat;
    }

    storageFile() {
      StorageFile storageFile = StorageFile();
      storageFile.location = value.location ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .location;
      storageFile.name = value.name ??
          all[selectedFolder.value].childrens[selectedElementIndex.value].name;
      storageFile.data = value.data ??
          all[selectedFolder.value].childrens[selectedElementIndex.value].data;
      storageFile.history = value.history ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .history;
      storageFile.animate = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .animate;
      storageFile.isPinned = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .isPinned;
      storageFile.dublicated = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .dublicated;
      storageFile.pathToImage = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .pathToImage;
      storageFile.link =
          all[selectedFolder.value].childrens[selectedElementIndex.value].link;
      storageFile.isLocked = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .isLocked;

      all[selectedFolder.value].childrens[selectedElementIndex.value] =
          storageFile;
    }

    todo() {
      Todo todo = Todo();
      todo.location = value.location ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .location;
      todo.name = value.name ??
          all[selectedFolder.value].childrens[selectedElementIndex.value].name;
      todo.tasks = value.tasks ??
          all[selectedFolder.value].childrens[selectedElementIndex.value].tasks;
      todo.animate = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .animate;
      todo.dublicated = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .dublicated;
      todo.isPinned = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .isPinned;
      todo.isLocked = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .isLocked;
      todo.link =
          all[selectedFolder.value].childrens[selectedElementIndex.value].link;

      all[selectedFolder.value].childrens[selectedElementIndex.value] = todo;
    }

    audioNote() {
      AudioNote audioNote = AudioNote();
      audioNote.location = value.location ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .location;
      audioNote.name = value.name ??
          all[selectedFolder.value].childrens[selectedElementIndex.value].name;
      audioNote.path = value.path ??
          all[selectedFolder.value].childrens[selectedElementIndex.value].path;
      audioNote.dublicated = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .dublicated;
      audioNote.animate = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .animate;
      audioNote.isLocked = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .isLocked;
      audioNote.isPinned = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .isPinned;
      audioNote.link =
          all[selectedFolder.value].childrens[selectedElementIndex.value].link;

      all[selectedFolder.value].childrens[selectedElementIndex.value] =
          audioNote;
    }

    switch (value.type) {
      case AllType.chat:
        chat();
        break;
      case AllType.storageFile:
        storageFile();
        break;
      case AllType.todo:
        todo();
        break;
      case AllType.audioNote:
        audioNote();
        break;
      default:
    }
    setData();
  }

  void addLink(dynamic value, int folderIndex) {
    chat() {
      Chat chat = Chat();
      chat.location = value.location ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .location;
      chat.name = value.name ??
          all[selectedFolder.value].childrens[selectedElementIndex.value].name;
      chat.messages = value.messages ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .messages;
      chat.favorites = value.favorites ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .favorites;
      chat.isPinned = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .isPinned;
      chat.animate = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .animate;
      chat.dublicated = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .dublicated;
      chat.pathToImage = value.pathToImage ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .pathToImage;
      chat.link = true;
      chat.isLocked = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .isLocked;
      chat.pinnedMessages = value.pinnedMessages ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .pinnedMessages;

      all[folderIndex].childrens.add(chat);
    }

    storageFile() {
      StorageFile storageFile = StorageFile();
      storageFile.location = value.location ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .location;
      storageFile.name = value.name ??
          all[selectedFolder.value].childrens[selectedElementIndex.value].name;
      storageFile.data = value.data ??
          all[selectedFolder.value].childrens[selectedElementIndex.value].data;
      storageFile.history = value.history ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .history;
      storageFile.animate = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .animate;
      storageFile.isPinned = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .isPinned;
      storageFile.dublicated = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .dublicated;
      storageFile.pathToImage = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .pathToImage;
      storageFile.link = true;
      storageFile.isLocked = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .isLocked;

      all[folderIndex].childrens.add(storageFile);
    }

    todo() {
      Todo todo = Todo();
      todo.location = value.location ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .location;
      todo.name = value.name ??
          all[selectedFolder.value].childrens[selectedElementIndex.value].name;
      todo.tasks = value.tasks ??
          all[selectedFolder.value].childrens[selectedElementIndex.value].tasks;
      todo.animate = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .animate;
      todo.dublicated = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .dublicated;
      todo.isPinned = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .isPinned;
      todo.isLocked = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .isLocked;
      todo.link = true;
      all[folderIndex].childrens.add(todo);
    }

    audioNote() {
      AudioNote audioNote = AudioNote();
      audioNote.location = value.location ??
          all[selectedFolder.value]
              .childrens[selectedElementIndex.value]
              .location;
      audioNote.name = value.name ??
          all[selectedFolder.value].childrens[selectedElementIndex.value].name;
      audioNote.path = value.path ??
          all[selectedFolder.value].childrens[selectedElementIndex.value].path;
      audioNote.dublicated = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .dublicated;
      audioNote.animate = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .animate;
      audioNote.isLocked = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .isLocked;
      audioNote.isPinned = all[selectedFolder.value]
          .childrens[selectedElementIndex.value]
          .isPinned;
      audioNote.link = true;

      all[folderIndex].childrens.add(audioNote);
    }

    switch (value.type) {
      case AllType.chat:
        chat();
        break;
      case AllType.storageFile:
        storageFile();
        break;
      case AllType.todo:
        todo();
        break;
      case AllType.audioNote:
        audioNote();
        break;
      default:
    }
    setData();
  }

  void addMessage(Message message) {
    all[selectedFolder.value]
        .childrens[selectedElementIndex.value]
        .messages
        .insert(0, message);
    setData();
  }

  void addChatImage(ChatImage image) {
    all[selectedFolder.value]
        .childrens[selectedElementIndex.value]
        .messages
        .insert(0, image);
    setData();
  }

  void addChatVoice(ChatVoice voice) {
    all[selectedFolder.value]
        .childrens[selectedElementIndex.value]
        .messages
        .insert(0, voice);
    setData();
  }

  void addChatFile(ChatFile file) {
    all[selectedFolder.value]
        .childrens[selectedElementIndex.value]
        .messages
        .insert(0, file);
    setData();
  }
}
