import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/pages/home_page/items/old_chat_page/widgets/type/chat_message.dart';

class ChatPageMessageInFullScreen extends StatelessWidget {
  final RxInt selected;
  final Message message;
  final String dateTime;
  final RxBool splitMessages;
  final RxBool showDate;
  final RxInt selectedMessageCount;
  final RxBool isShowColorSelector;
  final List selectedMessages;
  final RxList pinnedMessages;
  final RxBool moveMessage;
  const ChatPageMessageInFullScreen(
      {Key? key,
      required this.selected,
      required this.message,
      required this.showDate,
      required this.selectedMessageCount,
      required this.moveMessage,
      required this.splitMessages,
      required this.dateTime,
      required this.selectedMessages,
      required this.pinnedMessages,
      required this.isShowColorSelector})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          children: [
            MessageWidget(
              moveMessage: moveMessage,
              pinnedMessages: pinnedMessages,
              selectedMessagesCount: selectedMessageCount,
              fullScreen: true,
              splitMessages: splitMessages,
              dateTime: dateTime,
              showDate: showDate,
              selected: selected,
              message: message,
              selectedMessages: selectedMessages,
              isShowColorSelector: isShowColorSelector,
            ),
          ]),
    );
  }
}
