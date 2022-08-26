import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StorageFileHistory extends StatelessWidget {
  final List historyElements;
  final TextEditingController? dataController;
  const StorageFileHistory(
      {Key? key, required this.historyElements, this.dataController})
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
          itemCount: historyElements.length,
          itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(bottom: 4),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade600, width: 1)),
                child: GestureDetector(
                    onTap: () {
                      dataController!.text = historyElements[index];
                      Get.back();
                    },
                    child: Text(historyElements[index])),
              )),
    );
  }
}
