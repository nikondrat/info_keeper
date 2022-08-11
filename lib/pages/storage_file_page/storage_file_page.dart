import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/location_element.dart';
import 'package:info_keeper/model/types/storage_file.dart';
import 'package:info_keeper/pages/storage_file_page/storage_history_page.dart';
import 'package:info_keeper/pages/storage_file_page/widgets/storage_file_action.dart';
import 'package:info_keeper/pages/storage_file_page/widgets/storage_file_body.dart';
import 'package:info_keeper/pages/storage_file_page/widgets/storage_file_text_field.dart';
import 'package:info_keeper/widgets/background_image.dart';
import 'package:info_keeper/widgets/notifications.dart';
import 'package:path_provider/path_provider.dart';

class StorageFilePage extends StatelessWidget {
  final bool change;
  final StorageFile? file;
  const StorageFilePage({Key? key, this.file, this.change = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController title =
        TextEditingController(text: file != null ? file!.name : '');
    TextEditingController data =
        TextEditingController(text: file != null ? file!.data : '');
    final changeFile = change.obs;
    final history = [].obs;
    var pathToImage = ''.obs;

    if (change) {
      history.value = file!.history!;
      if (file!.pathToImage.isNotEmpty) {
        pathToImage.value = file!.pathToImage;
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
        Controller.to.change(
          StorageFile(
            pathToImage: pathToImage.value,
            location: LocationElement(
                inDirectory: Controller.to.selectedFolder.value,
                index: Controller.to.all[Controller.to.selectedFolder.value]
                        .directoryChildrens.length -
                    1),
          ),
        );
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
                locElement: file!.location!,
                name: file!.name!,
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
                        .directoryChildrens[
                    Controller.to.selectedElementIndex.value]);
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
                              historyElements: file!.history!.obs,
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
                        ? Controller.to.change(StorageFile(
                            name: title.text,
                            pathToImage: pathToImage.value,
                            history: history,
                            location: LocationElement(
                                inDirectory: Controller.to.selectedFolder.value,
                                index: Controller
                                        .to
                                        .all[Controller.to.selectedFolder.value]
                                        .directoryChildrens
                                        .length -
                                    1),
                            data: data.value.text))
                        : Controller.to.add(StorageFile(
                            name: title.text,
                            history: history,
                            location: LocationElement(
                                inDirectory: Controller.to.selectedFolder.value,
                                index: Controller
                                        .to
                                        .all[Controller.to.selectedFolder.value]
                                        .directoryChildrens
                                        .length -
                                    1),
                            pathToImage: pathToImage.value,
                            data: data.value.text));
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
