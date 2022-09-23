import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/message/message.dart';

class ChatMediaLinks extends StatelessWidget {
  final Chat chat;
  const ChatMediaLinks({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    RegExp regExp = RegExp(r'(https?://[^\s]+)');
    List<Message> linkInMessages = [];

    for (int i = 0; i < chat.messages.length; i++) {
      if (chat.messages[i].type == AllType.chatMessage &&
              !chat.messages[i].isLocked &&
              chat.messages[i].content.contains(regExp) ||
          chat.messages[i].type == AllType.chatMessage &&
              !chat.messages[i].isLocked &&
              chat.messages[i].title.contains(regExp)) {
        linkInMessages.insert(0, chat.messages[i]);
      }
    }

    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: linkInMessages.length,
        itemBuilder: (context, index) =>
            MessageWidget(message: linkInMessages[index], searchQuery: ''));
  }
}
