import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/item.dart';

class ChatPinnedMessages extends StatelessWidget {
  const ChatPinnedMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find();

    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                splashRadius: 20,
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back))),
        body: Obx(() => ListView.builder(
            itemCount: controller
                .pinnedMessages(controller.homeItem.child.messages)
                .length,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemBuilder: (context, index) => ChatItem(
                message: controller.pinnedMessages(
                    controller.homeItem.child.messages)[index]))));
  }
}
