import 'package:flutter/material.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/folder.dart';
import 'package:get/get.dart';

class HomePageAddFolder extends StatelessWidget {
  const HomePageAddFolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController folderTitleController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
            splashRadius: 20,
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back()),
        title: const Text('Add Folder'),
        actions: [
          IconButton(
            onPressed: () {
              if (folderTitleController.text.isNotEmpty) {
                Controller.to.all.add(Folder(
                    directoryName: folderTitleController.text,
                    directoryChildrens: [].obs));
                Controller.to.selectedFolder.value =
                    Controller.to.all.length - 1;
                Controller.to.setData();
                Get.back();
              }
            },
            icon: const Icon(Icons.add),
            splashRadius: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
            controller: folderTitleController,
            autofocus: true,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.send,
            maxLength: 20,
            decoration: const InputDecoration(
              hintText: 'Write folder name',
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            )),
      ),
    );
  }
}

class HomePageFoldersWidget extends StatelessWidget {
  final bool isSelect;
  const HomePageFoldersWidget({Key? key, this.isSelect = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final delete = false.obs;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
                Get.to(() => const HomePageAddFolder());
              },
              icon: const Icon(Icons.add),
              splashRadius: 20,
            ),
            const Icon(Icons.folder_copy_outlined),
            IconButton(
              icon: const Icon(Icons.close),
              splashRadius: 20,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        Expanded(
            child: Obx(() => LayoutBuilder(
                  builder: (context, constraints) => GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      itemCount: Controller.to.all.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: constraints.maxHeight / 140,
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8),
                      itemBuilder: (context, index) => HomePageFolderElement(
                            index: index,
                            isSelect: isSelect,
                            delete: delete,
                          )),
                )))
      ],
    );
  }
}

class HomePageFolderElement extends StatelessWidget {
  final int index;
  final bool isSelect;
  final RxBool delete;
  const HomePageFolderElement(
      {Key? key,
      required this.index,
      required this.isSelect,
      required this.delete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showMenu = false.obs;
    List list = [];
    for (int i = 0;
        i < Controller.to.all[index].directoryChildrens.length;
        i++) {
      if (!Controller.to.all[index].directoryChildrens[i].isLocked) {
        list.add(Controller.to.all[index].directoryChildrens[i]);
      }
    }

    ending() {
      if (list.length == 1) {
        return 'object';
      } else {
        return 'objects';
      }
    }

    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (isSelect) {
            showMenu.value = true;
          } else {
            Controller.to.selectedFolder.value = index;
            Navigator.pop(context);
          }
        },
        onLongPress: () {
          delete.value = true;
        },
        child: Obx(() => showMenu.value
            ? Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(6)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              var data = Controller
                                      .to
                                      .all[Controller.to.selectedFolder.value]
                                      .directoryChildrens[
                                  Controller.to.selectedElementIndex.value];
                              Controller
                                  .to
                                  .all[Controller.to.selectedFolder.value]
                                  .directoryChildrens
                                  .removeAt(
                                      Controller.to.selectedElementIndex.value);
                              Controller.to.selectedFolder.value = index;
                              Controller.to.add(data);
                              Controller.to.selectedFolder.value = index;
                              Navigator.pop(context);
                            },
                            child: const Text('MOVE'))),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          var element = Controller
                                  .to
                                  .all[Controller.to.selectedFolder.value]
                                  .directoryChildrens[
                              Controller.to.selectedElementIndex.value];

                          Controller.to.addLink(element, index);
                          Controller.to.selectedFolder.value = index;
                          Navigator.pop(context);
                        },
                        child: const Text('LINK'),
                      ),
                    ),
                  ],
                ))
            : Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(6)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              Controller.to.all[index].directoryName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          Text('${list.length} ${ending()}'),
                        ],
                      )),
                      delete.value && index != 0
                          ? IconButton(
                              onPressed: () {
                                Controller.to.all.removeAt(index);
                                //
                                Controller.to.selectedFolder.value = 0;
                              },
                              icon: const Icon(Icons.delete_outline),
                              splashRadius: 20,
                            )
                          : Container(),
                    ]))));
  }
}
