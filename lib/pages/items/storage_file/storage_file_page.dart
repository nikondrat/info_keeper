import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/home/storage_file/storage_file.dart';
import 'package:info_keeper/pages/items/storage_file/storage_history_page.dart';
import 'package:info_keeper/pages/items/storage_file/widgets/storage_file_body.dart';
import 'package:info_keeper/widgets/app_bar/app_bar.dart';
import 'package:info_keeper/widgets/notifications.dart';
import 'package:info_keeper/widgets/app_bar/widgets/title.dart';
import 'package:path_provider/path_provider.dart';

class StorageFilePage extends StatelessWidget {
  final bool change;
  final HomeItem homeItem;
  const StorageFilePage({Key? key, required this.homeItem, this.change = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RxBool changeTitle = false.obs;
    StorageFile storageFile = homeItem.child;
    TextEditingController title = TextEditingController(text: homeItem.name);
    FocusNode titleFocus = FocusNode();
    TextEditingController data = TextEditingController(text: storageFile.data);
    RxString pathToImage = storageFile.pathToImage.obs;

    void pickImage() async {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        Directory dir = await getApplicationDocumentsDirectory();
        File file = File(result.files.single.path.toString());
        String path = '${dir.path}/${result.files.single.name}';
        await file.copy(path);
        pathToImage.value = path;
      }
    }

    List<PopupMenuItem> changePopupMenuItems() => [
          PopupMenuItem(
              value: 0,
              onTap: () {
                Clipboard.setData(ClipboardData(text: data.value.text));
                Get.snackbar('Done', 'The content has been copied',
                    shouldIconPulse: true,
                    icon: const Icon(Icons.done),
                    margin: const EdgeInsets.all(10),
                    duration: const Duration(seconds: 1),
                    isDismissible: true,
                    snackPosition: SnackPosition.BOTTOM);
              },
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.copy),
                  ),
                  Text('Copy page')
                ],
              )),
          PopupMenuItem(
              value: 1,
              onTap: () => pickImage(),
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.palette_outlined),
                  ),
                  Text('Change background')
                ],
              )),
          PopupMenuItem(
              value: 2,
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.history),
                  ),
                  Text('Edit history')
                ],
              )),
          PopupMenuItem(
              value: 3,
              child: Notifications(
                locElement: homeItem.location,
                name: homeItem.name,
                isStorageFile: true,
              )),
          PopupMenuItem(
              onTap: () {
                if (storageFile.history!.indexOf(data.text) >= 1) {
                  data.text = storageFile
                      .history![storageFile.history!.indexOf(data.text) - 1];
                }
              },
              value: 4,
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.undo),
                  ),
                  Text('Undo')
                ],
              )),
          PopupMenuItem(
              value: 5,
              onTap: () {
                Get.back();
                Controller.to.delete(Controller
                    .to
                    .all[Controller.to.selectedFolder.value]
                    .childrens[Controller.to.selectedElementIndex.value]);
                Controller.to.setData();
              },
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.delete_outline),
                  ),
                  Text('Move to trash')
                ],
              )),
        ];

    List<PopupMenuItem> addPopupMenuItems() => [
          PopupMenuItem(
              value: 0,
              onTap: () {
                Clipboard.setData(ClipboardData(text: data.value.text));
                Get.snackbar('Done', 'The content has been copied',
                    shouldIconPulse: true,
                    icon: const Icon(Icons.done),
                    margin: const EdgeInsets.all(10),
                    duration: const Duration(seconds: 1),
                    isDismissible: true,
                    snackPosition: SnackPosition.BOTTOM);
              },
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.copy),
                  ),
                  Text('Copy page')
                ],
              )),
          PopupMenuItem(
              value: 1,
              onTap: () => pickImage(),
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.palette_outlined),
                  ),
                  Text('Change background')
                ],
              )),
        ];

    List<PopupMenuItem> popupItems() {
      List<PopupMenuItem> items = [];

      return items;
    }

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: AppBarWidget(
              controller: title,
              change: changeTitle,
              focus: titleFocus,
              leadingButtonFunc: () {
                if (change) {
                  storageFile.copyWith(
                      data: data.value.text,
                      history: storageFile.history,
                      pathToImage: pathToImage.value);
                } else {
                  Controller.to.all[homeItem.location.inDirectory].childrens
                      .removeAt(homeItem.location.index);
                }
                Get.back();
              },
              actions: [
                IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      storageFile.history!.add(data.text);
                      homeItem.copyWith(
                          name: title.text,
                          child: storageFile.copyWith(
                              data: data.text,
                              history: storageFile.history,
                              pathToImage: pathToImage.value));
                      Get.back();
                    },
                    icon: Icon(change ? Icons.done : Icons.add)),
                PopupMenuButton(
                    splashRadius: 20,
                    itemBuilder: (context) => popupItems(),
                    icon: const Icon(Icons.more_vert))
              ],
            )),

        // PopupMenuButton(
        //                 splashRadius: 20,
        //                 tooltip: '',
        //                 onSelected: (value) {
        //                   if (value == 2) {
        //                     Get.to(() => StorageFileHistory(
        //                           historyElements: storageFile.history!,
        //                           dataController: data,
        //                         ));
        //                   }
        //                 },
        //                 itemBuilder: (context) => change
        //                     ? changePopupMenuItems()
        //                     : addPopupMenuItems())
        //           ],

        body: StorageFilePageBody(
            dataController: data, pathToImage: pathToImage));
  }
}
