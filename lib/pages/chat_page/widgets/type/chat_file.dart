import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/theme.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';

class ChatPageFile extends StatelessWidget {
  final String name;
  final String path;
  final String dateTime;
  final RxBool showDate;
  const ChatPageFile(
      {Key? key,
      required this.name,
      required this.path,
      required this.dateTime,
      required this.showDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
    late DateTime time = format.parse(dateTime);

    return GestureDetector(
      onTap: () async => await OpenFilex.open(path),
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: messageColors[5],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.file_copy),
                  ),
                  Expanded(child: Text(name))
                ],
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
          )),
    );
  }
}
