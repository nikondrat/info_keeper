import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/pages/chat_page/chat_image_page.dart';
import 'package:info_keeper/pages/trash_page/trash_element.dart';
import 'package:info_keeper/themes/default/default.dart';
import 'package:intl/intl.dart';

class ChatImageWidget extends StatelessWidget {
  final String path;
  final String dateTime;
  final RxBool showDate;
  final int? index;
  final RxBool? moveMessage;
  final bool isTrash;
  const ChatImageWidget(
      {Key? key,
      required this.path,
      required this.dateTime,
      this.index,
      this.moveMessage,
      this.isTrash = false,
      required this.showDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime time = format.parse(dateTime);
    final isShowRestoreMenu = false.obs;

    return TrashElement(
      isShowRestoreMenu: isShowRestoreMenu,
      isMessage: true,
      index: index,
      child: GestureDetector(
        onLongPress: isTrash ? () => isShowRestoreMenu.value = true : null,
        onTap: isTrash
            ? null
            : () {
                if (moveMessage!.value) {
                  var message = Controller
                      .to
                      .all[Controller.to.selectedFolder.value]
                      .childrens[Controller.to.selectedElementIndex.value]
                      .child
                      .messages
                      .removeAt(Controller.to.firstSelectedMessage);
                  Controller
                      .to
                      .all[Controller.to.selectedFolder.value]
                      .childrens[Controller.to.selectedElementIndex.value]
                      .child
                      .messages
                      .insert(index, message);
                  moveMessage!.value = false;
                } else {
                  Get.to(
                      () => ChatImagePage(path: path, selectedMessage: index!));
                }
              },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: messageColors[5],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image(
                height: isTrash
                    ? MediaQuery.of(context).size.height * 0.2
                    : MediaQuery.of(context).size.height * 0.5,
                fit: BoxFit.cover,
                image: FileImage(File(path)),
              ),
              showDate.value
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          '${time.hour}:${time.minute}',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
