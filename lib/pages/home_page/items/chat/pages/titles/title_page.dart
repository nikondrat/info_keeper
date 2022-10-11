import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/chat_type.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/item.dart';

class ChatTitlesPage extends StatelessWidget {
  final Chat chat;
  const ChatTitlesPage({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final RxList messages = chat.messages.reversed.toList().obs;
    final RxList<Message> messagesWithTitle = <Message>[].obs;

    for (int i = 0; i < messages.length; i++) {
      if (messages[i].type == ChatType.message &&
          !messages[i].isLocked &&
          messages[i].title.isNotEmpty) {
        messagesWithTitle.add(messages[i]);
      }
    }

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              splashRadius: 20,
              onPressed: () {
                ChatController chatController = Get.find();
                chatController.isTitlesPage.value = false;
                Get.back();
              },
              icon: const Icon(Icons.arrow_back))),
      body: ListView.builder(
          itemCount: messagesWithTitle.length,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemBuilder: (context, index) {
            return ChatItem(message: messagesWithTitle[index]);
          }),
    );
  }
}
