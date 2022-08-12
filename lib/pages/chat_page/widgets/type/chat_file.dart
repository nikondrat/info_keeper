import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/theme.dart';
import 'package:intl/intl.dart';

class ChatPageFile extends StatelessWidget {
  final String dateTime;
  final RxBool showDate;
  const ChatPageFile({Key? key, required this.dateTime, required this.showDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
    late DateTime time = format.parse(dateTime);

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: messageColors[5],
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Row(
              children: const [Icon(Icons.file_copy)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                showDate.value
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 8, right: 8),
                        child: Text(
                          '${time.hour}:${time.minute}',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      )
                    : Container(),
              ],
            )
          ],
        ));
  }
}
