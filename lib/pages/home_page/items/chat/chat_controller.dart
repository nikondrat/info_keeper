import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ChatController extends GetxController {
  late HomeItem homeItem;
  late Message selectedMessage;
  // search
  final TextEditingController searchController = TextEditingController();
  final RxList searchItems = [].obs;

  // title
  final RxBool changeTitle = false.obs;
  final RxBool isSearch = false.obs;

  RxList<Message> pinnedMessages(RxList allMessages) {
    RxList<Message> pinnedMessages = <Message>[].obs;

    for (int i = 0; i < allMessages.length; i++) {
      if (allMessages[i].type == AllType.chatMessage &&
          !allMessages[i].isLocked &&
          allMessages[i].isPinned) {
        pinnedMessages.add(allMessages[i]);
      }
    }
    return pinnedMessages;
  }

  // body
  final RxBool showDate = false.obs;
  late AutoScrollController autoScrollController;

  RxBool uniteMessage = false.obs;
}
