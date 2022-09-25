import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/message/widgets/body.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/menu/menu.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final String searchQuery;
  final double elevation;
  const MessageWidget(
      {super.key,
      required this.message,
      this.elevation = 0,
      this.searchQuery = ''});

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.find();

    final Chat chat = chatController.homeItem.child;
    RxList messages = chat.messages;

    unlock() {
      message.isUnlocked = !message.isUnlocked;
      messages[messages.indexOf(message)] = message;
      chat.copyWith(messages: messages);
    }

    return GestureDetector(
        onTap: () {
          chatController.selectedMessage = message;
          if (message.isLocked && !message.isUnlocked) {
            unlock();
          } else {
            showBarModalBottomSheet(
                context: context,
                builder: (context) => MessageMenuWidget(message: message));
          }
        },
        child: //
            // Text('${message.isPinned}'));
            MessageWidgetBody(message: message, searchQuery: searchQuery));
  }
}
