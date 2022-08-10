import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/location_element.dart';
import 'package:info_keeper/model/types/storage_file.dart';

class StorageFilePageAction extends StatelessWidget {
  final RxList history;
  final TextEditingController titleController;
  final TextEditingController dataController;
  final RxBool changeFile;
  final RxString pathToImage;
  const StorageFilePageAction(
      {Key? key,
      required this.history,
      required this.titleController,
      required this.pathToImage,
      required this.dataController,
      required this.changeFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => changeFile.value
        ? IconButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                history.add(dataController.text);
                Controller.to.change(StorageFile(
                    history: history,
                    location: LocationElement(
                        inDirectory: Controller.to.selectedFolder.value,
                        index: Controller
                                .to
                                .all[Controller.to.selectedFolder.value]
                                .directoryChildrens
                                .length -
                            1),
                    name: titleController.text,
                    pathToImage: pathToImage.value,
                    data: dataController.text));
                Get.back();
              }
            },
            icon: const Icon(Icons.done),
            splashRadius: 20,
          )
        : IconButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                Controller.to.add(StorageFile(
                    history: history,
                    location: LocationElement(
                        inDirectory: Controller.to.selectedFolder.value,
                        index: Controller
                                .to
                                .all[Controller.to.selectedFolder.value]
                                .directoryChildrens
                                .length -
                            1),
                    name: titleController.text,
                    pathToImage: pathToImage.value,
                    data: dataController.text));
                changeFile.value = true;
                Get.back();
              }
            },
            icon: const Icon(Icons.add),
            splashRadius: 20,
          ));
  }
}
