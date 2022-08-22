import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/item_location.dart';
import 'package:info_keeper/model/types/home/storage_file/storage_file.dart';

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
                Controller.to.change(HomeItem(
                  name: titleController.text,
                  child: StorageFile(
                          pathToImage: pathToImage.value,
                          history: history,
                          data: dataController.text)
                      .obs,
                  location: ItemLocation(
                      inDirectory: Controller.to.selectedFolder.value,
                      index: Controller
                              .to
                              .all[Controller.to.selectedFolder.value]
                              .childrens
                              .length -
                          1),
                ));
                Get.back();
              }
            },
            icon: const Icon(Icons.done),
            splashRadius: 20,
          )
        : IconButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                Controller.to.all[Controller.to.selectedFolder.value].childrens
                    .add(HomeItem(
                  name: titleController.text,
                  child: StorageFile(data: dataController.text).obs,
                  location: ItemLocation(
                      inDirectory: Controller.to.selectedFolder.value,
                      index: Controller
                              .to
                              .all[Controller.to.selectedFolder.value]
                              .childrens
                              .length -
                          1),
                ));
                changeFile.value = true;
                Get.back();
              }
            },
            icon: const Icon(Icons.add),
            splashRadius: 20,
          ));
  }
}
