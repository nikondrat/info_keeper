import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/pages/search/search_body.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/with_time/body_with_time.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/reorderable_body.dart';

class ChatBody extends StatelessWidget {
  final Chat chat;
  final RxString pathToImage;
  const ChatBody({
    Key? key,
    required this.chat,
    required this.pathToImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.find();

    Widget body = Obx(() => chatController.isSearch.value
        ? const ChatSearchBody()
        : Transform.translate(
            offset: Offset(0, -1 * MediaQuery.of(context).viewInsets.bottom),
            child: chatController.showDate.value
                ? ChatBodyWithTime(chat: chat)
                : ChatReorderableBody(chat: chat),
          ));

    return Obx(() => pathToImage.isNotEmpty
        ? Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(File(pathToImage.value)),
                    fit: BoxFit.cover)),
            child: body)
        : body);
  }
}
