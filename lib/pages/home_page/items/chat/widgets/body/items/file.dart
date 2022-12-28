import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/items/file.dart';
import 'package:info_keeper/model/types/trash/trash_item.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/widgets/item_decoration.dart';
import 'package:open_filex/open_filex.dart';

class ChatFileWidget extends StatelessWidget {
  final ChatFile file;
  final double elevation;
  const ChatFileWidget({super.key, this.elevation = 0, required this.file});

  @override
  Widget build(BuildContext context) {
    return ItemDecoration(
        index: file.location.itemIndex!,
        dateTime: file.dateTime,
        elevation: elevation,
        child: GestureDetector(
          onTap: () async => await OpenFilex.open(file.path),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.file_copy, color: Colors.black),
              ),
              Expanded(
                  child: Text(file.name,
                      style: const TextStyle(color: Colors.black))),
              IconButton(
                  onPressed: () {
                    final ChatController chatController = Get.find();

                    final Chat chat = chatController.homeItem.child;
                    RxList messages = chat.messages;
                    Controller.to.trashElements
                        .add(TrashItem(child: file, isMessage: true));
                    messages.removeAt(messages.indexOf(file));
                  },
                  icon: const Icon(Icons.delete_outline, color: Colors.black))
            ],
          ),
        ));
  }
}
