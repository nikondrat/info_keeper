import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';

class ChatSearchTitle extends StatelessWidget {
  final RxList messages;
  const ChatSearchTitle({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find();

    final RxList items = [].obs;

    for (int i = 0; i < messages.length; i++) {
      if (messages[i].type == AllType.chatMessage && !messages[i].isLocked) {
        items.add(messages[i]);
      }
    }

    search(String text) {
      controller.searchItems.clear();
      if (text.isNotEmpty) {
        for (var item in items) {
          if (item.title.toLowerCase().contains(text) ||
              item.content.toLowerCase().contains(text)) {
            return controller.searchItems.add(item);
          }
        }
      } else {
        controller.searchItems.clear();
      }
    }

    // if (controller.searchController.text.isNotEmpty) {
    //   search(controller.searchController.text);
    // }

    TextField titleTextField = TextField(
      controller: controller.searchController,
      cursorColor: Colors.black,
      autofocus: true,
      // focusNode: focusNode,
      // onTap: () => change.value = true,
      decoration: InputDecoration(
          hintText: 'Search',
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          counterText: '',
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.red)),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          disabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6))),
      onEditingComplete: () {
        search(controller.searchController.text);
      },
      onChanged: search

      // for (int i = 0; i < messages.length; i++) {
      //   if (messages[i].type == AllType.chatMessage) {
      //     if (messages.contains(messages[i].content)) {
      //       controller.searchItems.add(messages[i]);
      //     }
      //   }
      // }
      // print(controller.searchItems);

      // if(messages. messages.contains(element)){}
      // if (messages.contains(element.title)) {
      //   controller.searchItems.add(element);
      // }
      ,
    );

    return titleTextField;
  }
}
