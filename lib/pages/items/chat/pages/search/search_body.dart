import 'package:flutter/material.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/items/item.dart';

class ChatSearchBody extends StatelessWidget {
  final List messages;
  const ChatSearchBody({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      reverse: true,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemBuilder: (context, index) =>
          ChatItem(index: index, message: messages[index]),
    );
  }
}
