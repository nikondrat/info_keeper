import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/chat/chat_type.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';

class ChatSearchTitle extends StatelessWidget {
  final RxList messages;
  const ChatSearchTitle({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    ChatController controller = Get.find();

    search(String text) {
      controller.searchItems.clear();
      for (var item in messages) {
        if (item.type == ChatType.message) {
          Message message = item;
          if (message.title.toLowerCase().contains(text) ||
              message.content.toLowerCase().contains(text) &&
                  !message.isLocked) {
            controller.searchItems.add(message);
          }
        }
      }
      if (text.isEmpty) {
        controller.searchItems.clear();
      }
    }

    TextField titleTextField = TextField(
        controller: controller.searchController,
        autofocus: true,
        decoration: const InputDecoration(
            hintText: 'Search',
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            counterText: ''),
        onEditingComplete: () {
          search(controller.searchController.text);
        },
        onChanged: search);

    return titleTextField;
  }
}
