import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';
import 'package:info_keeper/themes/default/default.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ItemDecoration extends StatelessWidget {
  final int index;
  final Widget child;
  final RxInt? color;
  final double elevation;
  final DateTime dateTime;
  final EdgeInsets? padding;
  const ItemDecoration(
      {Key? key,
      required this.index,
      this.color,
      this.elevation = 0,
      required this.child,
      this.padding,
      required this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find();

    String hour = dateTime.hour < 10 ? '0${dateTime.hour}' : '${dateTime.hour}';

    String minute =
        dateTime.minute < 10 ? '0${dateTime.minute}' : '${dateTime.minute}';

    return Material(
      color: Colors.transparent,
      elevation: elevation,
      child: Obx(
        () => AutoScrollTag(
            index: index,
            key: ValueKey(index),
            controller: controller.autoScrollController,
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 2),
                padding: padding ?? const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: messageColors[color?.value ?? defaultColor],
                    borderRadius: BorderRadius.circular(6)),

                // index:

                // child: Center(
                //   child: Text('$index'),
                // ))

                // body:
                child: controller.showDate.value
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
                    : child)),
      ),
    );
  }
}
