import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/home.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_page.dart';
import 'package:info_keeper/pages/home_page/items/storage_file/storage_file_page.dart';
import 'package:info_keeper/pages/home_page/items/task/task_page.dart';

class HomeBodyItemGesture extends StatelessWidget {
  final int homeItemIndex;
  final HomeItem homeItem;
  final Widget child;
  const HomeBodyItemGesture(
      {Key? key,
      required this.child,
      required this.homeItem,
      required this.homeItemIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final HomeController home = Get.find();

    return GestureDetector(
      onTap: () {
        home.isShowBottomMenu.value = false;
        if (home.isShowDialMenu.value) {
          home.toggle();
        }
        Controller.to.selectedElementIndex.value = homeItemIndex;
        switch (homeItem.child.type) {
          case HomeType.chat:
            Get.to(() => ChatPage(homeItem: homeItem));
            break;
          case HomeType.storageFile:
            Get.to(() => StorageFilePage(homeItem: homeItem, change: true));
            break;
          case HomeType.task:
            Get.to(() => TaskPage(homeItem: homeItem, change: true));
            break;
          case HomeType.audioNote:
            break;
          default:
        }
      },
      onLongPress: () {
        // print('index: $homeItemIndex');
        // print('homeitem location: ${homeItem.location.index}');
        home.isShowDialMenu.value = false;
        home.isShowBottomMenu.value = true;
        Controller.to.selectedElementIndex.value = homeItemIndex;
      },
      child: child,
    );
  }
}
