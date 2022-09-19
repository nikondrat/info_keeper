import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/pages/history/history_page.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/menu/item.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/message.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/btm_app_bar/btm_app_bar_controller.dart';
import 'package:info_keeper/widgets/notifications.dart';

class MessageMenuWidget extends StatelessWidget {
  final Message message;
  const MessageMenuWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final BottomAppBarController barController =
        Get.put(BottomAppBarController());
    final ChatController chatController = Get.find();

    final Chat chat = chatController.homeItem.child;

    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          children: [
            MenuItemWidget(
                title: 'Copy',
                icon: const Icon(Icons.copy),
                done: true,
                onPressed: () {
                  Navigator.pop(context);
                  Clipboard.setData(ClipboardData(text: message.content));
                  Get.snackbar('Done', 'The message has been copied',
                      shouldIconPulse: true,
                      icon: const Icon(Icons.done),
                      margin: const EdgeInsets.all(10),
                      duration: const Duration(seconds: 1),
                      isDismissible: true,
                      snackPosition: SnackPosition.BOTTOM);
                }),
            MenuItemWidget(
                title: 'Edit',
                done: true,
                icon: const Icon(Icons.edit_outlined),
                onPressed: () {
                  barController.isEditMessage.value = true;
                  barController.messageController.value =
                      TextEditingValue(text: message.content);
                  barController.titleController.value =
                      TextEditingValue(text: message.title);
                  barController.editMessageText.value = message.content;
                  // barController.textFieldIsEmpty.value = false;
                  Navigator.pop(context);
                }),
            MenuItemWidget(
                title: 'Highlite',
                icon: const Icon(Icons.brush_outlined),
                onPressed: () {
                  Navigator.pop(context);
                  barController.isShowColorSelector.value = true;
                }),
            MenuItemWidget(
                title: 'Edit history',
                icon: const Icon(Icons.history),
                done: true,
                onPressed: () {
                  Navigator.pop(context);
                  Get.to(
                      () => ChatMessageHistoryPage(history: message.history!));
                }),
            MenuItemWidget(
                title: 'Unite messages',
                icon: const Icon(Icons.forum_outlined),
                onPressed: () {
                  Navigator.pop(context);
                }),
            MenuItemWidget(
                title: 'Move message',
                icon: const Icon(Icons.drag_handle),
                onPressed: () {
                  Navigator.pop(context);
                }),
            MenuItemWidget(
                title: 'Full screen',
                icon: const Icon(Icons.open_in_full),
                done: true,
                onPressed: () {
                  Navigator.pop(context);
                  context.pushTransparentRoute(
                      MessageWidgetInFullScreen(message: message));
                }),
            MenuItemWidget(
                title: 'Pin',
                icon: const Icon(Icons.push_pin_outlined),
                onPressed: () {
                  Navigator.pop(context);
                }),
            MenuItemWidget(
                title: message.isFavorite
                    ? 'Remove from favorites'
                    : 'Add to favorites',
                done: true,
                icon: const Icon(Icons.star_outline),
                onPressed: () {
                  message.isFavorite = !message.isFavorite;
                  RxList messages = chat.messages;
                  messages[messages.indexOf(message)] = message;
                  chat.copyWith(messages: messages);
                  Navigator.pop(context);
                }),
            MenuItemWidget(
                title: 'Lock message',
                icon: const Icon(Icons.lock_outline),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Notifications(
              isChat: true,
              homeItem: chatController.homeItem,
            ),
            MenuItemWidget(
                title: 'Move to trash',
                icon: const Icon(Icons.delete),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ));
  }
}
