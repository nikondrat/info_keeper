import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/audio_note.dart';
import 'package:info_keeper/model/types/chat/chat.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/location_element.dart';
import 'package:info_keeper/model/types/storage_file.dart';
import 'package:info_keeper/model/types/todo.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';
import 'package:info_keeper/pages/home_page/widgets/folders/folders.dart';
import 'package:info_keeper/pages/vault_page/vault_page.dart';
import 'package:info_keeper/widgets/notifications.dart';

class HomePageBottomNavigationBar extends StatelessWidget {
  final bool isVault;
  const HomePageBottomNavigationBar({Key? key, this.isVault = false})
      : super(key: key);

  animate() {
    switch (Controller.to.all[Controller.to.selectedFolder.value]
        .childrens[Controller.to.selectedElementIndex.value].type) {
      case AllType.chat:
        Controller.to.change(Chat(
          animate: Controller.to.all[Controller.to.selectedFolder.value]
                  .childrens[Controller.to.selectedElementIndex.value].animate =
              !Controller.to.all[Controller.to.selectedFolder.value]
                  .childrens[Controller.to.selectedElementIndex.value].animate,
        ));
        break;
      case AllType.storageFile:
        Controller.to.change(StorageFile(
          animate: Controller.to.all[Controller.to.selectedFolder.value]
                  .childrens[Controller.to.selectedElementIndex.value].animate =
              !Controller.to.all[Controller.to.selectedFolder.value]
                  .childrens[Controller.to.selectedElementIndex.value].animate,
        ));
        break;
      case AllType.todo:
        Controller.to.change(Todo(
          animate: Controller.to.all[Controller.to.selectedFolder.value]
                  .childrens[Controller.to.selectedElementIndex.value].animate =
              !Controller.to.all[Controller.to.selectedFolder.value]
                  .childrens[Controller.to.selectedElementIndex.value].animate,
        ));
        break;
      case AllType.audioNote:
        Controller.to.change(AudioNote(
            animate: Controller
                    .to
                    .all[Controller.to.selectedFolder.value]
                    .childrens[Controller.to.selectedElementIndex.value]
                    .animate =
                !Controller
                    .to
                    .all[Controller.to.selectedFolder.value]
                    .childrens[Controller.to.selectedElementIndex.value]
                    .animate));
        break;
      default:
    }
  }

  lock() {
    if (Controller.to.password.isNotEmpty) {
      switch (Controller.to.all[Controller.to.selectedFolder.value]
          .childrens[Controller.to.selectedElementIndex.value].type) {
        case AllType.chat:
          Controller.to.change(Chat(
            isLocked: Controller
                    .to
                    .all[Controller.to.selectedFolder.value]
                    .childrens[Controller.to.selectedElementIndex.value]
                    .isLocked =
                !Controller
                    .to
                    .all[Controller.to.selectedFolder.value]
                    .childrens[Controller.to.selectedElementIndex.value]
                    .isLocked,
          ));
          break;
        case AllType.storageFile:
          Controller.to.change(StorageFile(
            isLocked: Controller
                    .to
                    .all[Controller.to.selectedFolder.value]
                    .childrens[Controller.to.selectedElementIndex.value]
                    .isLocked =
                !Controller
                    .to
                    .all[Controller.to.selectedFolder.value]
                    .childrens[Controller.to.selectedElementIndex.value]
                    .isLocked,
          ));
          break;
        case AllType.todo:
          Controller.to.change(Todo(
            isLocked: Controller
                    .to
                    .all[Controller.to.selectedFolder.value]
                    .childrens[Controller.to.selectedElementIndex.value]
                    .isLocked =
                !Controller
                    .to
                    .all[Controller.to.selectedFolder.value]
                    .childrens[Controller.to.selectedElementIndex.value]
                    .isLocked,
          ));
          break;
        case AllType.audioNote:
          Controller.to.change(AudioNote(
              isLocked: Controller
                      .to
                      .all[Controller.to.selectedFolder.value]
                      .childrens[Controller.to.selectedElementIndex.value]
                      .isLocked =
                  !Controller
                      .to
                      .all[Controller.to.selectedFolder.value]
                      .childrens[Controller.to.selectedElementIndex.value]
                      .isLocked));
          break;
        default:
      }
    } else {
      Get.to(() => VaultPage(
          selectedElement: Controller.to.selectedElementIndex, first: true));
    }
  }

  dublicate() {
    switch (Controller.to.all[Controller.to.selectedFolder.value]
        .childrens[Controller.to.selectedElementIndex.value].type) {
      case AllType.chat:
        Controller.to.add(Chat(
            name: Controller.to.all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value].name,
            messages: Controller.to.all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value].messages,
            favorites: Controller.to.all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value].favorites,
            isPinned: Controller.to.all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value].isPinned,
            animate: Controller.to.all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value].animate,
            dublicated: true,
            pathToImage: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value]
                .pathToImage,
            link: Controller.to.all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value].link,
            pinnedMessages: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value]
                .pinnedMessages));
        break;
      case AllType.storageFile:
        Controller.to.add(StorageFile(
            name: Controller.to.all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value].name,
            dublicated: true,
            history: Controller.to.all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value].history,
            link: Controller.to.all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value].link,
            data: Controller.to.all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value].data,
            pathToImage: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value]
                .pathToImage,
            animate: Controller.to.all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value].animate));
        break;
      case AllType.todo:
        Controller.to.add(Todo(
            name: Controller.to.all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value].name,
            dublicated: true,
            isPinned: Controller.to.all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value].isPinned,
            tasks: Controller.to.all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value].tasks,
            animate: Controller.to.all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value].animate));
        break;
      case AllType.audioNote:
        Controller.to.add(
          AudioNote(
              name: Controller.to.all[Controller.to.selectedFolder.value]
                  .childrens[Controller.to.selectedElementIndex.value].name,
              path: Controller.to.all[Controller.to.selectedFolder.value]
                  .childrens[Controller.to.selectedElementIndex.value].path,
              dublicated: true,
              isPinned: Controller.to.all[Controller.to.selectedFolder.value]
                  .childrens[Controller.to.selectedElementIndex.value].isPinned,
              animate: Controller.to.all[Controller.to.selectedFolder.value]
                  .childrens[Controller.to.selectedElementIndex.value].animate),
        );
        break;
      default:
    }
  }

  pin() {
    switch (Controller.to.all[Controller.to.selectedFolder.value]
        .childrens[Controller.to.selectedElementIndex.value].type) {
      case AllType.chat:
        Controller.to.change(Chat(
            isPinned: Controller
                    .to
                    .all[Controller.to.selectedFolder.value]
                    .childrens[Controller.to.selectedElementIndex.value]
                    .isPinned =
                !Controller
                    .to
                    .all[Controller.to.selectedFolder.value]
                    .childrens[Controller.to.selectedElementIndex.value]
                    .isPinned));
        break;
      case AllType.storageFile:
        Controller.to.change(StorageFile(
            isPinned: Controller
                    .to
                    .all[Controller.to.selectedFolder.value]
                    .childrens[Controller.to.selectedElementIndex.value]
                    .isPinned =
                !Controller
                    .to
                    .all[Controller.to.selectedFolder.value]
                    .childrens[Controller.to.selectedElementIndex.value]
                    .isPinned));
        break;
      case AllType.todo:
        Controller.to.change(Todo(
          isPinned: Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .childrens[Controller.to.selectedElementIndex.value]
                  .isPinned =
              !Controller.to.all[Controller.to.selectedFolder.value]
                  .childrens[Controller.to.selectedElementIndex.value].isPinned,
        ));
        break;
      case AllType.audioNote:
        Controller.to.change(AudioNote(
          isPinned: Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .childrens[Controller.to.selectedElementIndex.value]
                  .isPinned =
              !Controller.to.all[Controller.to.selectedFolder.value]
                  .childrens[Controller.to.selectedElementIndex.value].isPinned,
        ));
        break;
      default:
    }
    Controller.to.all[Controller.to.selectedFolder.value].childrens
        .sort((a, b) => a.isPinned ? 0 : 1);
  }

  popupItems(context) => [
        PopupMenuItem(
            onTap: () {
              // исчезновение решилось путем повторного вызова showModalBottomSheet

              // Controller.to.isShowMenu.value = false;
              Navigator.pop(context);
              showModalBottomSheet(
                  context: context,
                  builder: (context) => const HomeFolders(isSelect: true));
              showModalBottomSheet(
                  context: context,
                  builder: (context) => const HomeFolders(isSelect: true));
            },
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(Icons.folder_copy_outlined),
                ),
                Text('Add to folder')
              ],
            )),
        PopupMenuItem(
            onTap: () {
              dublicate();
              // Controller.to.isShowMenu.value = false;
            },
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(Icons.content_copy),
                ),
                Text('Dublicate')
              ],
            )),
        PopupMenuItem(
            onTap: () {
              // Controller.to.isShowMenu.value = false;

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

  vaultItems(context) => [
        PopupMenuItem(
            onTap: () {
              dublicate();
              // Controller.to.isShowMenu.value = false;
            },
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(Icons.content_copy),
                ),
                Text('Dublicate')
              ],
            )),
        PopupMenuItem(
            onTap: () {
              // Controller.to.isShowMenu.value = false;

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

  @override
  Widget build(BuildContext context) {
    late final HomeController home = Get.find();

    return Obx(() => BottomAppBar(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            home.isShowBottomMenu.value
                ? Container(
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                    )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            splashRadius: 20,
                            onPressed: () =>
                                home.isShowBottomMenu.value = false,
                            icon: const Icon(Icons.close)),
                        Row(
                          children: [
                            IconButton(
                                splashRadius: 20,
                                onPressed: () {
                                  pin();
                                  home.isShowBottomMenu.value = false;
                                },
                                icon: const Icon(Icons.push_pin_outlined)),
                            IconButton(
                              splashRadius: 20,
                              onPressed: () {
                                animate();
                                home.isShowBottomMenu.value = false;
                              },
                              icon: const Icon(
                                Icons.local_fire_department_outlined,
                              ),
                            ),
                            Notifications(
                              name: Controller
                                  .to
                                  .all[Controller.to.selectedFolder.value]
                                  .childrens[
                                      Controller.to.selectedElementIndex.value]
                                  .name,
                              locElement: LocationElement(
                                  inDirectory:
                                      Controller.to.selectedFolder.value,
                                  index:
                                      Controller.to.selectedElementIndex.value),
                            ),
                            IconButton(
                                splashRadius: 20,
                                onPressed: () {
                                  home.isShowBottomMenu.value = false;
                                  lock();
                                },
                                icon: const Icon(Icons.lock_outline)),
                            PopupMenuButton(
                                splashRadius: 20,
                                onSelected: (value) {},
                                offset: Offset(0, isVault ? -120 : -170),
                                itemBuilder: (context) => isVault
                                    ? vaultItems(context)
                                    : popupItems(context))
                          ],
                        ),
                      ],
                    ),
                  )
                : Container(),
            isVault
                ? const SizedBox.shrink()
                : Container(
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                    )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            splashRadius: 20,
                            onPressed: () {
                              Controller.to.selectedFolder.value = 0;
                            },
                            icon: const Icon(
                              Icons.home_outlined,
                              size: 26,
                            )),
                        Controller.to.selectedFolder.value == 0
                            ? IconButton(
                                splashRadius: 20,
                                onPressed: () => showModalBottomSheet(
                                    context: context,
                                    builder: (context) => const HomeFolders()),
                                icon: const Icon(Icons.folder_copy_outlined))
                            : TextButton(
                                onPressed: () => showModalBottomSheet(
                                    context: context,
                                    builder: (context) => const HomeFolders()),
                                child: Text(
                                  Controller
                                      .to
                                      .all[Controller.to.selectedFolder.value]
                                      .name,
                                  style: const TextStyle(fontSize: 16),
                                )),
                        const Flexible(
                          child: FractionallySizedBox(
                            widthFactor: 0.16,
                          ),
                        )
                      ],
                    )),
          ],
        )));
  }
}
