import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/menu/item.dart';

class MessageMenuWidget extends StatelessWidget {
  final Message message;
  const MessageMenuWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
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
                  Navigator.pop(context);
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
                onPressed: () {}),
            MenuItemWidget(
                title: 'Copy', icon: const Icon(Icons.copy), onPressed: () {}),
            MenuItemWidget(
                title: 'Copy', icon: const Icon(Icons.copy), onPressed: () {}),
            MenuItemWidget(
                title: 'Copy', icon: const Icon(Icons.copy), onPressed: () {}),
            MenuItemWidget(
                title: 'Copy', icon: const Icon(Icons.copy), onPressed: () {}),
            MenuItemWidget(
                title: 'Copy', icon: const Icon(Icons.copy), onPressed: () {}),
            MenuItemWidget(
                title: 'Copy', icon: const Icon(Icons.copy), onPressed: () {}),
            MenuItemWidget(
                title: 'Copy', icon: const Icon(Icons.copy), onPressed: () {}),
            MenuItemWidget(
                title: 'Copy', icon: const Icon(Icons.copy), onPressed: () {}),
          ],
        ));
  }
}
