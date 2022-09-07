import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/pages/items/chat/chat_controller.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ChatScrollerItem extends StatelessWidget {
  final int index;
  final Function()? onTap;
  final Widget child;
  const ChatScrollerItem(
      {super.key, this.onTap, required this.index, required this.child});

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.find();

    return GestureDetector(
        onTap: () {
          onTap != null ? onTap!() : null;
          print(index);
          chatController.autoScrollController
              .scrollToIndex(index, preferPosition: AutoScrollPosition.middle);
        },
        child: child);
  }
}
