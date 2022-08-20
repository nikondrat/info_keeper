import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/storage_file/storage_file.dart';
import 'package:info_keeper/model/types/home/todo/task.dart';
import 'package:info_keeper/model/types/home/todo/todo.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/item_location.dart';
import 'package:info_keeper/pages/audio_page/audio_page.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';
import 'package:info_keeper/pages/home_page/widgets/home_alert_dialog.dart';
import 'package:info_keeper/pages/storage_file_page/storage_file_page.dart';
import 'package:info_keeper/pages/todo_page/todo_page.dart';
import 'package:info_keeper/pages/home_page/widgets/fab_menu/fab.dart';

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
                Get.to(() => TodoPage(
                      homeItem: HomeItem(
                          child: Todo(tasks: <Task>[].obs),
                          location: ItemLocation(
                              inDirectory: Controller.to.selectedFolder.value,
                              index: Controller
                                      .to
                                      .all[Controller.to.selectedFolder.value]
                                      .childrens
                                      .length -
                                  1)),
                    ));
              },
              icon: const Icon(Icons.add_task),
              heroTag: 'floatbtn2',
              controller: controller,
            ),
            ActionButton(
              onPressed: () {
                _toggle();
                Get.to(() => const StorageFilePage());
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
                    builder: (context) => const HomePageAlertDialog());
              },
              icon: const Icon(Icons.chat_bubble_outline),
              heroTag: 'floatbtn4',
              controller: controller,
            )
          ])
        : const SizedBox());
  }
}
