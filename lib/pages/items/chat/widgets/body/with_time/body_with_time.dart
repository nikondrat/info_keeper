import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/pages/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/items/item.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/with_time/body_separator.dart';

class ChatBodyWithTime extends StatelessWidget {
  final Chat chat;
  const ChatBodyWithTime({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.find();

    return GroupedListView(
        controller: chatController.autoScrollController,
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        physics: const BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        sort: false,
        elements: chat.messages.reversed.toList(),
        groupBy: (dynamic element) => DateTime.utc(element.dateTime.year,
            element.dateTime.month, element.dateTime.day),
        groupSeparatorBuilder: (DateTime dateTime) =>
            ChatBodySeparator(dateTime: dateTime),
        indexedItemBuilder: (context, element, index) =>
            ChatItem(message: element));
  }
}
