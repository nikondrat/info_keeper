import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/audio_note.dart';
import 'package:info_keeper/model/types/chat/chat.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/location_element.dart';
import 'package:info_keeper/model/types/storage_file.dart';
import 'package:info_keeper/model/types/todo.dart';
import 'package:info_keeper/pages/home_page/widgets/home_folders.dart';
import 'package:info_keeper/widgets/notifications.dart';

class HomePageBottomNavigationBar extends StatelessWidget {
  final bool isVault;
  const HomePageBottomNavigationBar({Key? key, this.isVault = false})
      : super(key: key);

  animate() {
    switch (Controller.to.all[Controller.to.selectedFolder.value]
        .directoryChildrens[Controller.to.selectedElementIndex.value].type) {
      case AllType.chat:
        Controller.to.change(Chat(
          animate: Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .animate =
              !Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .animate,
        ));
        break;
      case AllType.storageFile:
        Controller.to.change(StorageFile(
          animate: Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .animate =
              !Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .animate,
        ));
        break;
      case AllType.todo:
        Controller.to.change(Todo(
          animate: Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .animate =
              !Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .animate,
        ));
        break;
      case AllType.audioNote:
        Controller.to.change(AudioNote(
            animate:
                Controller
                        .to
                        .all[Controller.to.selectedFolder.value]
                        .directoryChildrens[
                            Controller.to.selectedElementIndex.value]
                        .animate =
                    !Controller
                        .to
                        .all[Controller.to.selectedFolder.value]
                        .directoryChildrens[
                            Controller.to.selectedElementIndex.value]
                        .animate));
        break;
      default:
    }
  }

  lock() {
    switch (Controller.to.all[Controller.to.selectedFolder.value]
        .directoryChildrens[Controller.to.selectedElementIndex.value].type) {
      case AllType.chat:
        Controller.to.change(Chat(
          isLocked: Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .isLocked =
              !Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .isLocked,
        ));
        break;
      case AllType.storageFile:
        Controller.to.change(StorageFile(
          isLocked: Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .isLocked =
              !Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .isLocked,
        ));
        break;
      case AllType.todo:
        Controller.to.change(Todo(
          isLocked: Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .isLocked =
              !Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .isLocked,
        ));
        break;
      case AllType.audioNote:
        Controller.to.change(AudioNote(
            isLocked:
                Controller
                        .to
                        .all[Controller.to.selectedFolder.value]
                        .directoryChildrens[
                            Controller.to.selectedElementIndex.value]
                        .isLocked =
                    !Controller
                        .to
                        .all[Controller.to.selectedFolder.value]
                        .directoryChildrens[
                            Controller.to.selectedElementIndex.value]
                        .isLocked));
        break;
      default:
    }
  }

  dublicate() {
    switch (Controller.to.all[Controller.to.selectedFolder.value]
        .directoryChildrens[Controller.to.selectedElementIndex.value].type) {
      case AllType.chat:
        Controller.to.add(Chat(
            name: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .name,
            messages: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .messages,
            favorites: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .favorites,
            pinned: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .pinned,
            animate: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .animate,
            dublicated: true,
            pathToImage: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .pathToImage,
            link: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .link,
            pinnedMessages: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .pinnedMessages));
        break;
      case AllType.storageFile:
        Controller.to.add(StorageFile(
            name: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .name,
            dublicated: true,
            history: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .history,
            link: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .link,
            data: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .data,
            pathToImage: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .pathToImage,
            animate: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .animate));
        break;
      case AllType.todo:
        Controller.to.add(Todo(
            name: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .name,
            dublicated: true,
            pinned: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .pinned,
            tasks: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .tasks,
            animate: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .animate));
        break;
      case AllType.audioNote:
        Controller.to.add(
          AudioNote(
              name: Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .name,
              path: Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .path,
              dublicated: true,
              pinned: Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .pinned,
              animate: Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .animate),
        );
        break;
      default:
    }
  }

  pin() {
    switch (Controller.to.all[Controller.to.selectedFolder.value]
        .directoryChildrens[Controller.to.selectedElementIndex.value].type) {
      case AllType.chat:
        Controller.to.change(Chat(
            pinned:
                Controller
                        .to
                        .all[Controller.to.selectedFolder.value]
                        .directoryChildrens[
                            Controller.to.selectedElementIndex.value]
                        .pinned =
                    !Controller
                        .to
                        .all[Controller.to.selectedFolder.value]
                        .directoryChildrens[
                            Controller.to.selectedElementIndex.value]
                        .pinned));
        break;
      case AllType.storageFile:
        Controller.to.change(StorageFile(
            pinned:
                Controller
                        .to
                        .all[Controller.to.selectedFolder.value]
                        .directoryChildrens[
                            Controller.to.selectedElementIndex.value]
                        .pinned =
                    !Controller
                        .to
                        .all[Controller.to.selectedFolder.value]
                        .directoryChildrens[
                            Controller.to.selectedElementIndex.value]
                        .pinned));
        break;
      case AllType.todo:
        Controller.to.change(Todo(
          pinned: Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .pinned =
              !Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .pinned,
        ));
        break;
      case AllType.audioNote:
        Controller.to.change(AudioNote(
          pinned: Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .pinned =
              !Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .pinned,
        ));
        break;
      default:
    }
    Controller.to.all[Controller.to.selectedFolder.value].directoryChildrens
        .sort((a, b) => a.pinned ? 0 : 1);
  }

  popupItems(context) => [
        PopupMenuItem(
            onTap: () {
              // исчезновение решилось путем повторного вызова showModalBottomSheet

              Controller.to.isShowMenu.value = false;
              Navigator.pop(context);
              showModalBottomSheet(
                  context: context,
                  builder: (context) =>
                      const HomePageFoldersWidget(isSelect: true));
              showModalBottomSheet(
                  context: context,
                  builder: (context) =>
                      const HomePageFoldersWidget(isSelect: true));
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
              Controller.to.isShowMenu.value = false;
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
              Controller.to.isShowMenu.value = false;

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

  vaultItems(context) => [
        PopupMenuItem(
            onTap: () {
              dublicate();
              Controller.to.isShowMenu.value = false;
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
              Controller.to.isShowMenu.value = false;

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

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomAppBar(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Controller.to.isShowMenu.value
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
                                Controller.to.isShowMenu.value = false,
                            icon: const Icon(Icons.close)),
                        Row(
                          children: [
                            IconButton(
                                splashRadius: 20,
                                onPressed: () {
                                  pin();
                                  Controller.to.isShowMenu.value = false;
                                },
                                icon: const Icon(Icons.push_pin_outlined)),
                            IconButton(
                              splashRadius: 20,
                              onPressed: () {
                                animate();
                                Controller.to.isShowMenu.value = false;
                              },
                              icon: const Icon(
                                Icons.local_fire_department_outlined,
                              ),
                            ),
                            Notifications(
                              name: Controller
                                  .to
                                  .all[Controller.to.selectedFolder.value]
                                  .directoryChildrens[
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
                                  Controller.to.isShowMenu.value = false;
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
                                    builder: (context) =>
                                        const HomePageFoldersWidget()),
                                icon: const Icon(Icons.folder_copy_outlined))
                            : TextButton(
                                onPressed: () => showModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        const HomePageFoldersWidget()),
                                child: Text(Controller
                                    .to
                                    .all[Controller.to.selectedFolder.value]
                                    .directoryName)),
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
