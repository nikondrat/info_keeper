import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/item.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/with_time/body_separator.dart';

class ChatBodyWithTime extends StatelessWidget {
  final Chat chat;
  const ChatBodyWithTime({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.find();

    return Obx(() => chat.messages.isNotEmpty
        ? GroupedListView(
            controller: chatController.autoScrollController,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            sort: false,
            reverse: true,
            elements: chat.messages,
            groupBy: (dynamic element) => DateTime.utc(element.dateTime.year,
                element.dateTime.month, element.dateTime.day),
            groupSeparatorBuilder: (DateTime dateTime) =>
                ChatBodySeparator(dateTime: dateTime),
            indexedItemBuilder: (context, element, index) =>
                ChatItem(message: element))
        : const SizedBox());
  }
}
