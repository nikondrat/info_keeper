import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/items/image.dart';
import 'package:info_keeper/pages/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/items/scroller.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ChatMediaBody extends StatelessWidget {
  final Chat chat;
  const ChatMediaBody({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    List<ChatImage> images = [];

    for (int i = 0; i < chat.messages.length; i++) {
      if (chat.messages[i].type == AllType.chatImage) {
        images.add(chat.messages[i]);
      }
    }

    return GridView.builder(
      itemCount: images.length,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150, crossAxisSpacing: 4, mainAxisSpacing: 4),
      itemBuilder: (context, index) => ChatScrollerItem(
        index: images[index].location.itemIndex!,
        onTap: () => Get.back(),
        child: Image.file(
          File(images[index].path),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
