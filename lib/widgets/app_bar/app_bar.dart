import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/widgets/app_bar/widgets/title.dart';

class AppBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final RxBool change;
  final FocusNode focus;
  final List<Widget>? actions;
  final Function()? leadingButtonFunc;
  const AppBarWidget(
      {super.key,
      required this.controller,
      required this.change,
      this.actions,
      this.leadingButtonFunc,
      required this.focus});

  @override
  Widget build(BuildContext context) {
    String defaultText = controller.text;

    return Obx(() => AppBar(
          titleSpacing: 0,
          leading: IconButton(
              splashRadius: 20,
              onPressed: change.value
                  ? () {
                      change.value = !change.value;
                      controller.text = defaultText;
                      focus.unfocus();
                    }
                  : leadingButtonFunc,
              icon: Icon(change.value ? Icons.close : Icons.arrow_back)),
          title: TitleWidget(
              controller: controller, change: change, focusNode: focus),
          actions: change.value
              ? [
                  IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          change.value = !change.value;
                          focus.unfocus();
                          defaultText = controller.text;
                        }
                      },
                      icon: const Icon(Icons.done))
                ]
              : actions ??
                  [
                    const SizedBox(
                      width: 20,
                    )
                  ],
        ));
  }
}
