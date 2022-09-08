import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/items/file.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/items/file.dart';

class ChatMediaFiles extends StatelessWidget {
  final Chat chat;
  const ChatMediaFiles({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    List<ChatFile> files = [];

    for (int i = 0; i < chat.messages.length; i++) {
      if (chat.messages[i].type == AllType.chatFile) {
        files.insert(0, chat.messages[i]);
      }
    }

    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: files.length,
        itemBuilder: (context, index) => ChatFileWidget(file: files[index]));
  }
}
