import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/items/message.dart';

class ChatReorderableBody extends StatelessWidget {
  final Chat chat;
  const ChatReorderableBody({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RxList messages = chat.messages;

    return ReorderableListView.builder(
        proxyDecorator: (child, index, animation) => MessageWidget(
            key: Key('$index'), message: messages[index], drag: true),
        itemCount: messages.length,
        reverse: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemBuilder: (context, index) {
          messages[index].location.itemIndex = index;
          return MessageWidget(key: Key('$index'), message: messages[index]);
        },
        onReorder: (oldIndex, newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final message = messages.removeAt(oldIndex);
          messages.insert(newIndex, message);
          message.location.itemIndex = newIndex;
          chat.copyWith(messages: messages);
          Controller.to.setData();
        });
  }
}
