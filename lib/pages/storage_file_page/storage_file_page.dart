import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/item_location.dart';
import 'package:info_keeper/model/types/home/storage_file/storage_file.dart';
import 'package:info_keeper/pages/storage_file_page/storage_history_page.dart';
import 'package:info_keeper/pages/storage_file_page/widgets/storage_file_action.dart';
import 'package:info_keeper/pages/storage_file_page/widgets/storage_file_body.dart';
import 'package:info_keeper/pages/storage_file_page/widgets/storage_file_text_field.dart';
import 'package:info_keeper/widgets/background_image.dart';
import 'package:info_keeper/widgets/notifications.dart';
import 'package:path_provider/path_provider.dart';

class StorageFilePage extends StatelessWidget {
  final bool change;
  final HomeItem homeItem;
  const StorageFilePage({Key? key, required this.homeItem, this.change = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController(text: homeItem.name);
    TextEditingController data =
        TextEditingController(text: homeItem.child.data);
    final changeFile = change.obs;
    final history = [].obs;
    var pathToImage = ''.obs;

    if (change) {
      history.value = homeItem.child.history;
      if (homeItem.child.pathToImage.isNotEmpty) {
        pathToImage.value = homeItem.child.pathToImage;
        Controller.to.setData();
      }
    }

    void pickImage() async {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        Directory dir = await getApplicationDocumentsDirectory();
        File file = File(result.files.single.path.toString());
        String path = '${dir.path}/${result.files.single.name}';
        await file.copy(path);
        pathToImage.value = path;
        Controller.to.change(HomeItem(
          name: title.text,
          child: StorageFile(
                  pathToImage: pathToImage.value,
                  history: history,
                  data: data.value.text)
              .obs,
          location: ItemLocation(
              inDirectory: Controller.to.selectedFolder.value,
              index: Controller.to.all[Controller.to.selectedFolder.value]
                      .childrens.length -
                  1),
        ));
      }
    }

    List<PopupMenuItem> changePopupMenuItems(BoxConstraints constraints) => [
          PopupMenuItem(
              value: 0,
              onTap: () {
                Clipboard.setData(ClipboardData(text: data.value.text));
                Get.snackbar('Done', 'The content has been copied',
                    shouldIconPulse: true,
                    icon: const Icon(Icons.done),
                    margin: const EdgeInsets.all(10),
                    duration: const Duration(seconds: 1),
                    maxWidth: constraints.maxWidth * 0.9,
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
                if (history.indexOf(data.text) >= 1) {
                  data.text = history[history.indexOf(data.text) - 1];
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

    List<PopupMenuItem> addPopupMenuItems(BoxConstraints constraints) => [
          PopupMenuItem(
              value: 0,
              onTap: () {
                Clipboard.setData(ClipboardData(text: data.value.text));
                Get.snackbar('Done', 'The content has been copied',
                    shouldIconPulse: true,
                    icon: const Icon(Icons.done),
                    margin: const EdgeInsets.all(10),
                    duration: const Duration(seconds: 1),
                    maxWidth: constraints.maxWidth * 0.9,
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

    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              titleSpacing: 0,
              actions: [
                StorageFilePageAction(
                    history: history,
                    titleController: title,
                    dataController: data,
                    pathToImage: pathToImage,
                    changeFile: changeFile),
                PopupMenuButton(
                    splashRadius: 20,
                    tooltip: '',
                    onSelected: (value) {
                      if (value == 2) {
                        Get.to(() => StorageFileHistory(
                              historyElements: homeItem.child.history!.obs,
                              dataController: data,
                            ));
                      }
                    },
                    itemBuilder: (context) => change
                        ? changePopupMenuItems(constraints)
                        : addPopupMenuItems(constraints))
              ],
              leading: IconButton(
                splashRadius: 20,
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (title.text.isNotEmpty) {
                    changeFile.value
                        ? Controller.to.change(HomeItem(
                            name: title.text,
                            child: StorageFile(
                                pathToImage: pathToImage.value,
                                history: history,
                                data: data.value.text),
                            location: ItemLocation(
                                inDirectory: Controller.to.selectedFolder.value,
                                index: Controller
                                    .to
                                    .all[Controller.to.selectedFolder.value]
                                    .childrens
                                    .length),
                          ))
                        : Controller.to.add(HomeItem(
                            name: title.text,
                            child: StorageFile(
                                history: history,
                                pathToImage: pathToImage.value,
                                data: data.value.text),
                            location: ItemLocation(
                                inDirectory: Controller.to.selectedFolder.value,
                                index: Controller
                                    .to
                                    .all[Controller.to.selectedFolder.value]
                                    .childrens
                                    .length),
                          ));
                  }
                  Get.back();
                },
              ),
              title: StorageFilePageTextField(
                history: history,
                titleController: title,
                dataController: data,
                change: changeFile,
              )),
          body: Obx(() => pathToImage.isNotEmpty
              ? BackgroundImageWidget(
                  image: pathToImage.value,
                  child: StorageFilePageBody(dataController: data))
              : StorageFilePageBody(dataController: data))),
    );
  }
}
