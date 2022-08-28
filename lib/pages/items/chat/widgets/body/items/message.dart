import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/themes/default/default.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final bool drag;
  const MessageWidget({Key? key, required this.message, this.drag = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          boxShadow: drag
              ? [
                  BoxShadow(
                      offset: Offset(0, 2), blurRadius: 4, color: Colors.grey)
                ]
              : [],
          color: messageColors[5],
          borderRadius: BorderRadius.circular(6)),
      child: Text(message.messageText),
    );
  }
}
