import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';
import 'package:info_keeper/themes/default/default.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ItemDecoration extends StatelessWidget {
  final int index;
  final Widget child;
  final int? color;
  final bool isSelected;
  final double elevation;
  final DateTime dateTime;
  final EdgeInsets? padding;
  final bool isTrash;
  const ItemDecoration(
      {Key? key,
      required this.index,
      this.isSelected = false,
      this.color,
      this.elevation = 0,
      required this.child,
      this.padding,
      this.isTrash = false,
      required this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find();

    String hour = dateTime.hour < 10 ? '0${dateTime.hour}' : '${dateTime.hour}';

    String minute =
        dateTime.minute < 10 ? '0${dateTime.minute}' : '${dateTime.minute}';

    Widget body = controller.showDate.value
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              child,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  padding != null
                      ? Padding(
                          padding: const EdgeInsets.all(8),
                          child: AutoSizeText('$hour:$minute'))
                      : AutoSizeText('$hour:$minute')
                ],
              ),
            ],
          )
        : child;

    Widget bodyDecoration = Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: padding ?? const EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: isSelected ? Border.all() : null,
            color: isSelected
                ? Colors.white
                : messageColors[color ?? defaultColor],
            borderRadius: BorderRadius.circular(6)),

        // index:

        // child: Center(
        //   child: Text('$index'),
        // ))

        // body:
        child: body);

    return Material(
        color: Colors.transparent,
        elevation: elevation,
        child: isTrash
            ? bodyDecoration
            : AutoScrollTag(
                index: index,
                key: ValueKey(index),
                controller: controller.autoScrollController,
                child: bodyDecoration));
  }
}
