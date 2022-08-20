import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/home.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';
import 'package:info_keeper/pages/todo_page/todo_page.dart';

class HomeBodyItemGesture extends StatelessWidget {
  final int index;
  final HomeItem homeItem;
  final Widget child;
  const HomeBodyItemGesture(
      {Key? key,
      required this.child,
      required this.homeItem,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final HomeController home = Get.find();

    return GestureDetector(
      onTap: () {
        home.isShowDialMenu.value = false;
        home.isShowBottomMenu.value = false;
        switch (homeItem.child.type) {
          case HomeType.chat:
            break;
          case HomeType.storageFile:
            print('storage');
            break;
          case HomeType.todo:
            Get.to(() => TodoPage(homeItem: homeItem, change: true));
            break;
          case HomeType.audioNote:
            break;
          default:
        }
      },
      onLongPress: () {
        home.isShowBottomMenu.value = true;
        Controller.to.selectedElementIndex.value = index;
      },
      child: child,
    );
  }
}
