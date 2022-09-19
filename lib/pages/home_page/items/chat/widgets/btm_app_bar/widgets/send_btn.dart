import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/item_location.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/btm_app_bar/btm_app_bar_controller.dart';

class ChatBottomSendButton extends StatelessWidget {
  final HomeItem homeItem;
  const ChatBottomSendButton({Key? key, required this.homeItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Chat chat = homeItem.child;
    RxList messages = chat.messages;

    sendMessage(BottomAppBarController controller) {
      messages.insert(
          0,
          Message(
              title: controller.titleController.text,
              location: ItemLocation(
                  inDirectory: homeItem.location.inDirectory,
                  index: homeItem.location.index,
                  itemIndex: messages.length),
              content: controller.messageController.text,
              history: [],
              dateTime: DateTime.now()));
      chat.copyWith(messages: messages);
    }

    editMessage(BottomAppBarController controller) {
      Message message = messages[Controller.to.selectedElementIndex.value];
      final List history = message.history ?? [];

      message.title = controller.titleController.text;
      message.content = controller.messageController.text;
      history.add(message.content);
      message.history = history;
      chat.copyWith(messages: messages);
      controller.isEditMessage.value = false;
    }

    return GetBuilder<BottomAppBarController>(
      init: BottomAppBarController(),
      builder: (controller) => IconButton(
          splashRadius: 20,
          onPressed: () {
            controller.isEditMessage.value
                ? editMessage(controller)
                : sendMessage(controller);
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
