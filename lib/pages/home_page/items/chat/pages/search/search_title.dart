import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/chat/chat_type.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';

class ChatSearchTitle extends StatelessWidget {
  final RxList messages;
  const ChatSearchTitle({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find();

    search(String text) {
      controller.searchItems.clear();
      for (var item in messages) {
        if (item.type == ChatType.message) {
          if (item.title.toLowerCase().contains(text) ||
              item.content.toLowerCase().contains(text) && !item.isLocked) {
            return controller.searchItems.add(item);
          }
        } else {
          controller.searchItems.clear();
        }
      }
      controller.searchItems.clear();
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
