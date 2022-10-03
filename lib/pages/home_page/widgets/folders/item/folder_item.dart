import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/folder.dart';
import 'package:info_keeper/pages/home_page/widgets/folders/item/folder_item_menu.dart';

class FolderItem extends StatelessWidget {
  final int index;
  final RxBool delete;
  final bool isSelect;
  const FolderItem(
      {Key? key,
      required this.index,
      required this.delete,
      required this.isSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Folder folder = Controller.to.all[index];
    final showMenu = false.obs;

    return LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
            onTap: isSelect
                ? () {
                    showMenu.value = true;
                    20.seconds.delay(() => showMenu.value = false);
                  }
                : () {
                    Controller.to.selectedFolder.value = index;
                    Navigator.pop(context);
                  },
            onLongPress: () => delete.value = !delete.value,
            child: Container(
                padding: EdgeInsets.all(constraints.maxWidth * 0.04),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(6)),
                child: Obx(() => showMenu.value
                    ? FolderItemMenu(index: index)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  AutoSizeText(
                                    folder.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Expanded(
                                      child: AutoSizeText(
                                    '${folder.childrens.length} ${folder.childrens.length == 1 ? 'object' : 'objects'}',
                                    style: const TextStyle(fontSize: 14),
                                  ))
                                ])),
                            delete.value && index != 0
                                ? IconButton(
                                    onPressed: () {
                                      Controller.to.all.removeAt(index);
                                      Controller.to.selectedFolder.value = 0;
                                      Navigator.pop(context);
                                      delete.value = !delete.value;
                                    },
                                    icon: const Icon(
                                      Icons.delete_outline,
                                    ),
                                    splashRadius: 20,
                                  )
                                : Container(),
                          ])))));
  }
}
