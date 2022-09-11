import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/old_chat.dart';
import 'package:info_keeper/themes/default/default.dart';

class ChatPageColorItem extends StatelessWidget {
  final int colorIndex;
  final RxInt selectedMessage;
  final RxInt selectedIndex;
  const ChatPageColorItem(
      {Key? key,
      required this.colorIndex,
      required this.selectedMessage,
      required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () {
            selectedIndex.value = colorIndex;
            List messages = Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value]
                .child
                .value
                .messages!;
            messages[selectedMessage.value].selectedColorIndex =
                selectedIndex.value;

            Controller.to.change(ChatItem(
              messages: messages.obs,
            ));
          },
          child: Container(
            decoration: BoxDecoration(
                color: messageColors[colorIndex],
                border: selectedIndex.value == colorIndex
                    ? Border.all(color: Colors.black, width: 2)
                    : null,
                shape: BoxShape.circle),
          ),
        ));
  }
}
