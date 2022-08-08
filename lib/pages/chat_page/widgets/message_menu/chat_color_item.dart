import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/chat/chat.dart';
import 'package:info_keeper/theme.dart';

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
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .messages!;
            messages[selectedMessage.value].selectedColorIndex =
                selectedIndex.value;

            Controller.to.change(Chat(
                type: AllType.chat,
                name: Controller
                    .to
                    .all[Controller.to.selectedFolder.value]
                    .directoryChildrens[
                        Controller.to.selectedElementIndex.value]
                    .name,
                messages: messages.obs,
                favorites: Controller
                    .to
                    .all[Controller.to.selectedFolder.value]
                    .directoryChildrens[
                        Controller.to.selectedElementIndex.value]
                    .favorites,
                animate: Controller
                    .to
                    .all[Controller.to.selectedFolder.value]
                    .directoryChildrens[
                        Controller.to.selectedElementIndex.value]
                    .animate));
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
