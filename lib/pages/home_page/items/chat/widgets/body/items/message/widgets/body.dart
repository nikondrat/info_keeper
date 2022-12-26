import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/message/widgets/content_text.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/widgets/item_decoration.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/widgets/locked_decoration.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/btm_app_bar/btm_app_bar_controller.dart';
import 'package:swipe_to/swipe_to.dart';

class MessageWidgetBody extends StatelessWidget {
  final Message message;
  final String searchQuery;
  final double elevation;
  final bool isVault;
  final bool isTrash;
  const MessageWidgetBody(
      {Key? key,
      required this.message,
      this.elevation = 0,
      this.isVault = false,
      this.isTrash = false,
      this.searchQuery = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.put(ChatController());
    final BottomAppBarController barController =
        Get.put(BottomAppBarController());

    Widget title = Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.grey.shade400),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              MessageWidgetText(text: message.title, searchQuery: searchQuery)),
    );

    Widget content = Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpandableNotifier(
            child: ScrollOnExpand(
                child: Row(children: [
          message.content.split(' ').length > 100
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpandableButton(
                    child:
                        const Icon(Icons.close_fullscreen, color: Colors.black),
                  ),
                )
              : const SizedBox(),
          Expanded(
              child: ExpandablePanel(
                  collapsed: MessageWidgetText(
                      text: message.content,
                      maxLines:
                          message.content.split(' ').length > 100 ? 3 : null,
                      searchQuery: searchQuery),
                  expanded: MessageWidgetText(
                      text: message.content, searchQuery: searchQuery))),
          message.isFavorite
              ? Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.grey),
                  child: const Icon(Icons.star, color: Colors.yellowAccent))
              : const SizedBox(),
          message.isLocked
              ? GestureDetector(
                  onTap: () {
                    final ChatController chatController = Get.find();
                    final Chat chat = chatController.homeItem.child;
                    RxList messages = chat.messages;

                    if (isVault) {
                      message.isLocked = !message.isLocked;
                    } else {
                      message.isUnlocked = !message.isUnlocked;
                    }

                    messages[messages.indexOf(message)] = message;
                    chat.copyWith(messages: messages);
                  },
                  child: const Icon(Icons.lock_open, color: Colors.black))
              : const SizedBox(),
        ]))));

    Widget decoration = ItemDecoration(
        index: message.location.itemIndex!,
        color: message.color,
        isSelected: message.isSelected,
        elevation: elevation,
        padding: EdgeInsets.zero,
        dateTime: message.dateTime,
        isTrash: isTrash,
        child: message.title.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [title, content])
            : content);

    Widget swiper = SwipeTo(
        onRightSwipe: () {
          chatController.selectedMessage = message;
          barController.isEditMessage.value = true;
          barController.messageController.value =
              TextEditingValue(text: message.content);
          barController.titleController.value =
              TextEditingValue(text: message.title);
          barController.editMessageText.value = message.content;
        },
        child: decoration);

    return message.isLocked && !isVault && !message.isUnlocked
        ? LockedDecorationWidget(message: message)
        : isTrash
            ? decoration
            : swiper;
  }
}
