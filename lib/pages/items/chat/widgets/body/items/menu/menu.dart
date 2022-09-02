import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/items/menu/item.dart';

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
