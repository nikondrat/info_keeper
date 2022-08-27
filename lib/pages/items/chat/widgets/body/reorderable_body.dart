import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home/chat/old_chat.dart';

class ChatReorderableBody extends StatelessWidget {
  final ChatItem chat;
  const ChatReorderableBody({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemBuilder: (context, index) => Text(key: UniqueKey(), '$index'),
        itemCount: 20,
        reverse: true,
        onReorder: (oldIndex, newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
        });
  }
}
