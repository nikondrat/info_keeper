import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';

class ChatImagePage extends StatelessWidget {
  final String path;
  final int selectedMessage;
  const ChatImagePage(
      {Key? key, required this.path, required this.selectedMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                splashRadius: 20,
                onPressed: () {
                  Get.back();
                  var message = Controller
                      .to
                      .all[Controller.to.selectedFolder.value]
                      .childrens[Controller.to.selectedElementIndex.value]
                      .messages
                      .removeAt(selectedMessage);

                  Controller.to.trashElements.add(message);
                  Controller.to.setData();
                },
                icon: const Icon(Icons.delete))
          ],
          leading: IconButton(
              splashRadius: 20,
              onPressed: () => Get.back(),
              icon: const Icon(Icons.close))),
      body: Center(
        child: Image(
          filterQuality: FilterQuality.high,
          image: FileImage(File(path)),
        ),
      ),
    );
  }
}
