import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/chat/chat.dart';

class ChatPageTitle extends StatelessWidget {
  final int index;
  final RxBool renameChat;
  const ChatPageTitle({Key? key, required this.renameChat, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(
        text: Controller
            .to.all[Controller.to.selectedFolder.value].childrens[index].name);

    return Obx(() => renameChat.value
        ? TextField(
            controller: titleController,
            autofocus: true,
            cursorColor: Colors.black,
            decoration: InputDecoration(
                hintText: 'Title',
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(width: 1, color: Colors.red)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      width: 1,
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      width: 1,
                    )),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      width: 1,
                    )),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    width: 1,
                  ),
                )),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                Controller.to.change(Chat(name: titleController.text));
                // Controller.to.change(Chat(
                //     type: AllType.chat,
                //     name: titleController.text,
                //     pathToImage: pathToImage.value,
                //     favorites: Controller
                //         .to
                //         .all[Controller.to.selectedFolder.value]
                //         .childrens[
                //             Controller.to.selectedElementIndex.value]
                //         .favorites,
                //     messages: Controller
                //         .to
                //         .all[Controller.to.selectedFolder.value]
                //         .childrens[
                //             Controller.to.selectedElementIndex.value]
                //         .messages));
                renameChat.value = false;
              }
            },
          )
        : Text(Controller.to.all[Controller.to.selectedFolder.value]
            .childrens[Controller.to.selectedElementIndex.value].name!));
  }
}
