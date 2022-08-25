import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/item_location.dart';
import 'package:info_keeper/model/types/home/storage_file/storage_file.dart';

class StorageFilePageAction extends StatelessWidget {
  final HomeItem homeItem;
  final List history;
  final TextEditingController titleController;
  final TextEditingController dataController;
  final bool change;
  final String pathToImage;
  const StorageFilePageAction(
      {Key? key,
      required this.homeItem,
      required this.history,
      required this.titleController,
      required this.pathToImage,
      required this.dataController,
      required this.change})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: change
          ? () {
              history.add(dataController.text);
              homeItem.copyWith(
                  name: titleController.text,
                  child: homeItem.child.copyWith(
                      data: dataController.text,
                      history: history,
                      pathToImage: pathToImage));
              Get.back();
            }
          : () {
              Get.back();
            },
      icon: Icon(change ? Icons.done : Icons.add),
      splashRadius: 20,
    );
  }
}
