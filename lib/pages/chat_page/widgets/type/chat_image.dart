import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/theme.dart';
import 'package:intl/intl.dart';

class ChatImageWidget extends StatelessWidget {
  final String path;
  final String dateTime;
  final RxBool showDate;
  const ChatImageWidget(
      {Key? key,
      required this.path,
      required this.dateTime,
      required this.showDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime time = format.parse(dateTime);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: messageColors[5],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image(
            fit: BoxFit.cover,
            image: FileImage(File(path)),
          ),
          showDate.value
              ? Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '${time.hour}:${time.minute}',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
