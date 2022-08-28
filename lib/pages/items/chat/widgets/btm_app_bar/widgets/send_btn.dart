import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/item_location.dart';
import 'package:info_keeper/pages/items/chat/widgets/btm_app_bar/btm_app_bar_controller.dart';

class ChatBottomSendButton extends StatelessWidget {
  final HomeItem homeItem;
  const ChatBottomSendButton({Key? key, required this.homeItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxList messages = homeItem.child.messages;

    return GetBuilder<BottomAppBarController>(
      init: BottomAppBarController(),
      builder: (controller) => IconButton(
          splashRadius: 20,
          onPressed: () {
            messages.add(Message(
                location: ItemLocation(
                    inDirectory: homeItem.location.inDirectory,
                    index: homeItem.location.index,
                    itemIndex: homeItem.child.messages.length),
                messageText: controller.messageController.text,
                dateTime: ''));
            homeItem.child.copyWith(messages: messages);
            Controller.to.setData();

            controller.isShowTitleTextField.value = false;
            controller.titleController.clear();
            controller.messageController.clear();
            controller.textFieldIsEmpty.value = true;
            FocusScope.of(context).unfocus();
            controller.update();
          },
          icon: const Icon(Icons.send)),
    );
  }
}
