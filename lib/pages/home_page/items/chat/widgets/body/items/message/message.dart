import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/message/widgets/body.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/menu/menu.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final String searchQuery;
  final double elevation;
  final bool isVault;
  const MessageWidget(
      {super.key,
      required this.message,
      this.isVault = false,
      this.elevation = 0,
      this.searchQuery = ''});

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.put(ChatController());

    final Chat chat = chatController.homeItem.child;
    RxList messages = chat.messages;

    move() {
      if (chatController.secondSelectedMessage != null) {
        int oldIndex =
            chatController.secondSelectedMessage!.location.itemIndex!;
        int newIndex = message.location.itemIndex!;
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        Message selectedMessage = messages.removeAt(oldIndex);
        selectedMessage.isSelected = false;
        messages.insert(newIndex, selectedMessage);

        chatController.moveMessage.value = false;
        Controller.to.setData();
      }
    }

    unite() {
      message.isSelected = !message.isSelected;
      messages[messages.indexOf(message)] = message;
      chat.copyWith(messages: messages);
      Controller.to.setData();
    }

    unlock() {
      change() {
        message.isUnlocked = !message.isUnlocked;
        messages[messages.indexOf(message)] = message;
        chat.copyWith(messages: messages);
      }

      Future.delayed(const Duration(seconds: 40)).whenComplete(() => change());
      change();
    }

    showBottomMenu() {
      showBarModalBottomSheet(
          context: context,
          builder: (context) => MessageMenuWidget(message: message));
    }

    onTap() {
      chatController.selectedMessage = message;

      if (message.isLocked && !message.isUnlocked && !isVault) {
        unlock();
      } else if (chatController.uniteMessage.value) {
        unite();
      } else if (chatController.moveMessage.value) {
        move();
      } else {
        showBottomMenu();
      }
    }

    return GestureDetector(
        onTap: onTap,
        child: //
            // Text('${message.isPinned}'));
            MessageWidgetBody(
                message: message, searchQuery: searchQuery, isVault: isVault));
  }
}
