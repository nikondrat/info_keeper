import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/pages/home_page/items/widgets/app_bar/widgets/title.dart';

class AppBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final double titleSpacing;
  final bool centerTitle;
  final RxBool change;
  final Widget? title;
  final FocusNode focus;
  final Widget? leading;
  final List<Widget>? actions;
  final Function() leadingButtonFunc;
  const AppBarWidget(
      {super.key,
      this.titleSpacing = 0,
      this.leading,
      required this.controller,
      this.centerTitle = false,
      required this.change,
      this.title,
      this.actions,
      required this.leadingButtonFunc,
      required this.focus});

  @override
  Widget build(BuildContext context) {
    String defaultText = controller.text;

    return Obx(() => AppBar(
          titleSpacing: titleSpacing,
          centerTitle: centerTitle,
          leading: leading ??
              IconButton(
                  splashRadius: 20,
                  onPressed: change.value
                      ? () {
                          change.value = !change.value;
                          controller.text = defaultText;
                          focus.unfocus();
                        }
                      : leadingButtonFunc,
                  icon: Icon(change.value ? Icons.close : Icons.arrow_back)),
          title: title ??
              TitleWidget(
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
