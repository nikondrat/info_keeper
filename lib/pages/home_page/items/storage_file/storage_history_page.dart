import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/storage_file/storage_file.dart';

class StorageFileHistory extends StatelessWidget {
  final StorageFile storageFile;
  final TextEditingController? dataController;

  const StorageFileHistory(
      {Key? key, required this.storageFile, this.dataController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
          splashRadius: 20,
        ),
      ),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          itemCount: storageFile.history!.length,
          itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(bottom: 4),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade600, width: 1)),
                child: GestureDetector(
                    onTap: () {
                      if (dataController!.text.isNotEmpty &&
                          !storageFile.history!
                              .contains(dataController!.text)) {
                        storageFile.history!.add(dataController!.text);
                      }
                      dataController!.text = storageFile.history![index];
                      Get.back();
                    },
                    child: Text(storageFile.history![index])),
              )),
    );
  }
}
