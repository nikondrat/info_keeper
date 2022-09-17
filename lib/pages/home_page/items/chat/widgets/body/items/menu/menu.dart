import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/menu/item.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/btm_app_bar/btm_app_bar_controller.dart';
import 'package:info_keeper/widgets/notifications.dart';

class MessageMenuWidget extends StatelessWidget {
  final Message message;
  const MessageMenuWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final BottomAppBarController controller = Get.find();
    final ChatController chatController = Get.find();

    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            MenuItemWidget(
                title: 'Copy',
                icon: const Icon(Icons.copy),
                onPressed: () {
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
                icon: const Icon(Icons.edit_outlined),
                onPressed: () {}),
            MenuItemWidget(
                title: 'Highlite',
                icon: const Icon(Icons.brush_outlined),
                onPressed: () => controller.isShowColorSelector.value = true),
            MenuItemWidget(
                title: 'Edit history',
                icon: const Icon(Icons.history),
                onPressed: () {}),
            MenuItemWidget(
                title: 'Unite messages',
                icon: const Icon(Icons.forum_outlined),
                onPressed: () {}),
            MenuItemWidget(
                title: 'Move message',
                icon: const Icon(Icons.drag_handle),
                onPressed: () {}),
            MenuItemWidget(
                title: 'Collapse message',
                icon: const Icon(Icons.close_fullscreen),
                onPressed: () {}),
            MenuItemWidget(
                title: 'Full screen',
                icon: const Icon(Icons.open_in_full),
                onPressed: () {}),
            MenuItemWidget(
                title: 'Pin',
                icon: const Icon(Icons.push_pin_outlined),
                onPressed: () {}),
            MenuItemWidget(
                title: 'Add to favorites',
                icon: const Icon(Icons.star_outline),
                onPressed: () {}),
            MenuItemWidget(
                title: 'Lock message',
                icon: const Icon(Icons.lock_outline),
                onPressed: () {}),
            // Notifications(
            //   homeItem: chatController.homeItem,
            //   child: Row(
            //     children: [
            //       Icon(Icons.notifications_none),
            //       Expanded(
            //           child: Text(
            //         'Remind',
            //         style: TextStyle(fontSize: 14),
            //       ))
            //     ],
            //   ),
            // ),
            MenuItemWidget(
                title: 'Move to trash',
                icon: const Icon(Icons.delete),
                onPressed: () {})
          ],
        ));
  }
}
