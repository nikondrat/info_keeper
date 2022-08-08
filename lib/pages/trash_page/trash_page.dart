import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/all.dart';

class TrashPage extends StatelessWidget {
  const TrashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          splashRadius: 20,
          onPressed: () => Get.back(),
        ),
      ),
      body: MasonryGridView.count(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          itemCount: Controller.to.trashElements.length,
          itemBuilder: (context, index) {
            switch (Controller.to.trashElements[index].type) {
              case AllType.chat:
                return Container();
              case AllType.storageFile:
                return Container();
              default:
                return Container();
            }
          }),
    );
  }
}
