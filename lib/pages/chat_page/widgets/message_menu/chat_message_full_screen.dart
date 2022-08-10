import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/chat/message.dart';
import 'package:info_keeper/pages/chat_page/widgets/type/chat_message.dart';

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
  const ChatPageMessageInFullScreen(
      {Key? key,
      required this.selected,
      required this.message,
      required this.showDate,
      required this.selectedMessageCount,
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
