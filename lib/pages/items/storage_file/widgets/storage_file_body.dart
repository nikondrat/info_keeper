import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StorageFilePageBody extends StatelessWidget {
  final TextEditingController dataController;
  final RxString pathToImage;
  const StorageFilePageBody(
      {Key? key, required this.dataController, required this.pathToImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget body = TextField(
      keyboardType: TextInputType.multiline,
      autocorrect: true,
      controller: dataController,
      maxLines: null,
      expands: true,
      cursorColor: Colors.black,
      decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Text',
          contentPadding: EdgeInsets.all(12)),
    );

    return Obx(() => pathToImage.isNotEmpty
        ? Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(File(pathToImage.value)),
                    fit: BoxFit.cover)),
            child: body)
        : body);
  }
}
