import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/btm_app_bar/btm_app_bar_controller.dart';
import 'package:info_keeper/themes/default/default.dart';

class ColorSelectorItem extends StatelessWidget {
  final int itemIndex;
  final Chat chat;
  final Message message;
  const ColorSelectorItem(
      {super.key,
      required this.itemIndex,
      required this.message,
      required this.chat});

  @override
  Widget build(BuildContext context) {
    final BottomAppBarController bottomAppBarController = Get.find();

    return GestureDetector(
      onTap: () {
        bottomAppBarController.selectedColor.value = itemIndex;
        RxList messages = chat.messages;
        message.color = itemIndex;
        messages[messages.indexOf(message)] = message;
        chat.copyWith(messages: messages);
      },
      child: Obx(() => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: messageColors[itemIndex],
              border: bottomAppBarController.selectedColor.value == itemIndex
                  ? Border.all(color: Colors.black, width: 2)
                  : null,
            ),
          )),
    );
  }
}
