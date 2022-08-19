import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/pages/home_page/widgets/folders/folders.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      IconButton(
          splashRadius: 20,
          onPressed: () {
            Controller.to.selectedFolder.value = 0;
          },
          icon: const Icon(
            Icons.home_outlined,
            size: 26,
          )),
      Obx(() => Controller.to.selectedFolder.value == 0
          ? IconButton(
              splashRadius: 20,
              onPressed: () => showModalBottomSheet(
                  context: context, builder: (context) => const HomeFolders()),
              icon: const Icon(Icons.folder_copy_outlined))
          : TextButton(
              onPressed: () => showModalBottomSheet(
                  context: context, builder: (context) => const HomeFolders()),
              child: Text(
                Controller.to.all[Controller.to.selectedFolder.value].name,
                style: const TextStyle(fontSize: 16),
              ))),
      const Flexible(
        child: FractionallySizedBox(
          widthFactor: 0.16,
        ),
      )
    ]);
  }
}
