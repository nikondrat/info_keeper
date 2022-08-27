import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/pages/items/old_chat_page/widgets/type/chat_message.dart';

class ChatPagePinnedMessages extends StatelessWidget {
  final RxList messages;
  const ChatPagePinnedMessages({
    Key? key,
    required this.messages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              splashRadius: 20,
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back)),
        ),
        body: ListView.builder(
            itemCount: messages.length,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            physics: const BouncingScrollPhysics(),
            itemBuilder: ((context, index) => MessageWidgetBody(
                  message: messages[index],
                  dateTime: messages[index].dateTime,
                ))));
  }
}
