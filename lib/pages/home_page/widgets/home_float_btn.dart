import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/pages/audio_page/audio_page.dart';
import 'package:info_keeper/pages/home_page/widgets/home_alert_dialog.dart';
import 'package:info_keeper/pages/storage_file_page/storage_file_page.dart';
import 'package:info_keeper/pages/todo_page/todo_page.dart';
import 'package:info_keeper/widgets/fab.dart';

class HomePageFloatButton extends StatefulWidget {
  const HomePageFloatButton({Key? key}) : super(key: key);

  @override
  State<HomePageFloatButton> createState() => _HomePageFloatButtonState();
}

class _HomePageFloatButtonState extends State<HomePageFloatButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      value: Controller.to.isShowDial.value ? 1.0 : 0.0,
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
    setState(() {
      Controller.to.isShowDial.value = !Controller.to.isShowDial.value;
      controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Controller.to.isShowMenu.value
          ? Container()
          : ExpandableFab(
              distance: 100,
              controller: controller,
              children: [
                ActionButton(
                  onPressed: () {
                    Get.to(() => const AudioPage());
                    _toggle();
                  },
                  icon: const Icon(Icons.keyboard_voice_outlined),
                  heroTag: 'floatbtn1',
                  controller: controller,
                ),
                ActionButton(
                  onPressed: () {
                    Get.to(() => const TodoPage());
                    _toggle();
                  },
                  icon: const Icon(Icons.add_task),
                  heroTag: 'floatbtn2',
                  controller: controller,
                ),
                ActionButton(
                  onPressed: () {
                    Get.to(() => const StorageFilePage());
                    _toggle();
                  },
                  icon: const Icon(Icons.file_open_outlined),
                  heroTag: 'floatbtn3',
                  controller: controller,
                ),
                ActionButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => const HomePageAlertDialog());
                    _toggle();
                  },
                  icon: const Icon(Icons.chat_bubble_outline),
                  heroTag: 'floatbtn4',
                  controller: controller,
                )
              ],
            ),
    );
  }
}
