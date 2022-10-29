import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/storage_file/storage_file.dart';
import 'package:info_keeper/model/types/home/task/task.dart';
import 'package:info_keeper/model/types/home/task/todo.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/item_location.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';
import 'package:info_keeper/pages/home_page/widgets/fab_menu/fab.dart';
import 'package:info_keeper/pages/home_page/widgets/alert_dialog.dart';
import 'package:info_keeper/pages/home_page/items/audio/audio_page.dart';
import 'package:info_keeper/pages/home_page/items/storage_file/storage_file_page.dart';
import 'package:info_keeper/pages/home_page/items/task/task_page.dart';

class HomeFloatButtons extends StatefulWidget {
  const HomeFloatButtons({Key? key}) : super(key: key);

  @override
  State<HomeFloatButtons> createState() => _HomeFloatButtonsState();
}

class _HomeFloatButtonsState extends State<HomeFloatButtons>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final HomeController home = Get.find();

  @override
  void initState() {
    controller = AnimationController(
      value: home.isShowDialMenu.value && !home.isShowBottomMenu.value ? 1 : 0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    home.controller = controller;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _toggle() {
    home.isShowDialMenu.value = !home.isShowDialMenu.value;
    home.isShowBottomMenu.value = false;
    controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => !home.isShowBottomMenu.value
        ? ExpandableFab(distance: 100, controller: controller, children: [
            ActionButton(
              onPressed: () {
                _toggle();
                Get.to(() => const AudioPage());
              },
              icon: const Icon(Icons.keyboard_voice_outlined),
              heroTag: 'floatbtn1',
              controller: controller,
            ),
            ActionButton(
              onPressed: () {
                _toggle();
                HomeItem homeItem = HomeItem(
                    name: '',
                    child: Task(todos: <Todo>[].obs),
                    location: ItemLocation(
                        inDirectory: Controller.to.selectedFolder.value,
                        index: Controller
                            .to
                            .all[Controller.to.selectedFolder.value]
                            .childrens
                            .length));
                Controller.to.add(homeItem);
                Controller.to.selectedElementIndex.value =
                    homeItem.location.index;
                Get.to(() => TaskPage(homeItem: homeItem));
              },
              icon: const Icon(Icons.add_task),
              heroTag: 'floatbtn2',
              controller: controller,
            ),
            ActionButton(
              onPressed: () {
                _toggle();
                HomeItem homeItem = HomeItem(
                    name: '',
                    child: StorageFile(history: []),
                    location: ItemLocation(
                        inDirectory: Controller.to.selectedFolder.value,
                        index: Controller
                            .to
                            .all[Controller.to.selectedFolder.value]
                            .childrens
                            .length));
                Controller.to.add(homeItem);
                Controller.to.selectedElementIndex.value =
                    homeItem.location.index;
                Get.to(() => StorageFilePage(
                      homeItem: homeItem,
                    ));
              },
              icon: const Icon(Icons.file_open_outlined),
              heroTag: 'floatbtn3',
              controller: controller,
            ),
            ActionButton(
              onPressed: () {
                _toggle();
                showDialog(
                    context: context,
                    builder: (context) => const HomeAlertDialog());
              },
              icon: const Icon(Icons.chat_bubble_outline),
              heroTag: 'floatbtn4',
              controller: controller,
            )
          ])
        : const SizedBox());
  }
}
