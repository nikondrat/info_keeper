import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/home.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/item_location.dart';
import 'package:info_keeper/model/types/home/storage_file/storage_file.dart';

class StorageFilePageTextField extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController dataController;
  final RxBool change;
  final RxList history;
  const StorageFilePageTextField(
      {Key? key,
      required this.titleController,
      required this.dataController,
      required this.history,
      required this.change})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: titleController,
      autofocus: change.value ? false : true,
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
      onSubmitted: (String value) {
        if (value.isNotEmpty) {
          Controller.to.all[Controller.to.selectedFolder.value].childrens
              .add(HomeItem(
            name: value,
            child: StorageFile(data: dataController.text),
            location: ItemLocation(
                inDirectory: Controller.to.selectedFolder.value,
                index: Controller.to.all[Controller.to.selectedFolder.value]
                        .childrens.length -
                    1),
          ));
        }
      },
    );
  }
}
