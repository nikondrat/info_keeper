import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/pages/items/chat/chat_controller.dart';
import 'package:info_keeper/themes/default/default.dart';

class ItemDecoration extends StatelessWidget {
  final Widget child;
  final int? color;
  final double elevation;
  final DateTime dateTime;
  const ItemDecoration(
      {Key? key,
      this.color,
      required this.child,
      this.elevation = 0,
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
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: messageColors[color ?? defaultColor],
              borderRadius: BorderRadius.circular(6)),
          child: Obx(() => controller.showDate.value
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    child,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AutoSizeText('$hour:$minute'),
                      ],
                    ),
                  ],
                )
              : child)),
    );
  }
}
