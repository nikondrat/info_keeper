import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/pages/home_page/widgets/folders/add_folder.dart';
import 'package:info_keeper/pages/home_page/widgets/folders/item/folder_item.dart';

class HomeFolders extends StatelessWidget {
  final bool isSelect;
  const HomeFolders({Key? key, this.isSelect = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RxBool isDelete = false.obs;

    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
            Get.to(() => const AddFolderPage());
          },
          icon: const Icon(
            Icons.add,
          ),
          splashRadius: 20,
        ),
        const Icon(
          Icons.folder_copy_outlined,
        ),
        IconButton(
          icon: const Icon(Icons.close),
          splashRadius: 20,
          onPressed: () => Navigator.pop(context),
        )
      ]),
      Expanded(
          child: Obx(() => GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: Controller.to.all.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: MediaQuery.of(context).size.height * 0.0022,
                  maxCrossAxisExtent: 200,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8),
              itemBuilder: (context, index) => FolderItem(
                  index: index, delete: isDelete, isSelect: isSelect))))
    ]);
  }
}
