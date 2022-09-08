import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/pages/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/items/item.dart';

class ChatReorderableBody extends StatelessWidget {
  final Chat chat;
  const ChatReorderableBody({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.find();
    RxList messages = chat.messages;

    return Obx(() => ReorderableListView.builder(
        scrollController: chatController.autoScrollController,
        proxyDecorator: (child, index, animation) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(0, 6, animValue)!;

          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) => ChatItem(
                key: Key('$index'),
                elevation: elevation,
                message: messages[index]),
          );
        },
        itemCount: messages.length,
        reverse: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemBuilder: (context, index) {
          messages[index].location.itemIndex = index;

          return ChatItem(key: Key('$index'), message: messages[index]);
        },
        onReorder: (oldIndex, newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final message = messages.removeAt(oldIndex);
          messages.insert(newIndex, message);
          chat.copyWith(messages: messages);
        }));
  }
}
