import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/folder.dart';

class AddFolderPage extends StatelessWidget {
  const AddFolderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController folderTitleController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
            splashRadius: 20,
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back()),
        title: const Text('Add Folder'),
        actions: [
          IconButton(
            onPressed: () {
              if (folderTitleController.text.isNotEmpty) {
                Controller.to.all.add(Folder(
                    name: folderTitleController.text, childrens: [].obs));
                Controller.to.selectedFolder.value =
                    Controller.to.all.length - 1;
                Controller.to.setData();
                Get.back();
              }
            },
            icon: const Icon(Icons.add),
            splashRadius: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
            controller: folderTitleController,
            autofocus: true,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.send,
            maxLength: 20,
            decoration: const InputDecoration(
              hintText: 'Write folder name',
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            )),
      ),
    );
  }
}
