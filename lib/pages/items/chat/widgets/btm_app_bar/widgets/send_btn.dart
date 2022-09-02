import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
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
    Chat chat = homeItem.child;
    RxList messages = chat.messages;

    return GetBuilder<BottomAppBarController>(
      init: BottomAppBarController(),
      builder: (controller) => IconButton(
          splashRadius: 20,
          onPressed: () {
            messages.insert(
                0,
                Message(
                    title: controller.titleController.text,
                    location: ItemLocation(
                        inDirectory: homeItem.location.inDirectory,
                        index: homeItem.location.index,
                        itemIndex: messages.length),
                    content: controller.messageController.text,
                    dateTime: DateTime.now()));
            chat.copyWith(messages: messages);
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
