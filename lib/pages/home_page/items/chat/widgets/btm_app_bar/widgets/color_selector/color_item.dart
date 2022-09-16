import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/btm_app_bar/btm_app_bar_controller.dart';
import 'package:info_keeper/themes/default/default.dart';

class ColorSelectorItem extends StatelessWidget {
  final int itemIndex;
  final HomeItem homeItem;
  const ColorSelectorItem(
      {super.key, required this.itemIndex, required this.homeItem});

  @override
  Widget build(BuildContext context) {
    final BottomAppBarController bottomAppBarController = Get.find();

    return GestureDetector(
      onTap: () {
        bottomAppBarController.selectedColor.value = itemIndex;
        Chat chat = homeItem.child;
        RxList messages = chat.messages;
        messages[Controller.to.selectedElementIndex.value].color = itemIndex;
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
