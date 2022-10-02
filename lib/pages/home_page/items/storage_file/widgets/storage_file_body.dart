import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/themes/widgets/body.dart';

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

    return BodyWithTheme(body: body, pathToImage: pathToImage.value);
  }
}
