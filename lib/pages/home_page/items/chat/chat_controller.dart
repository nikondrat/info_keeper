import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ChatController extends GetxController {
  late HomeItem homeItem;
  // search
  final TextEditingController searchController = TextEditingController();
  final RxList searchItems = [].obs;

  // title
  final RxBool changeTitle = false.obs;
  final RxBool isSearch = false.obs;
  RxList<Message> pinnedMessages = <Message>[].obs;

  // body
  final RxBool showDate = false.obs;
  late AutoScrollController autoScrollController;

  refreshPinnedMessages(RxList messages) {
    for (int i = 0; i < messages.length; i++) {
      if (messages[i].type == AllType.chatMessage &&
          !messages[i].isLocked &&
          messages[i].isPinned) {
        pinnedMessages.add(messages[i]);
      }
    }
  }

  // bottom

  //  = AutoScrollController(
  //    viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, 1),
  //   axis: Axis.vertical,
  // );
}
