import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/item.dart';

class ChatSearchBody extends StatelessWidget {
  const ChatSearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find();

    return Obx(() => ListView.builder(
          itemCount: controller.searchItems.length,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemBuilder: (context, index) => ChatItem(
              message: controller.searchItems[index],
              searchQuery: controller.searchController.text),
        ));
  }
}
