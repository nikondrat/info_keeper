import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/items/item_decoration.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final double elevation;
  const MessageWidget({Key? key, required this.message, this.elevation = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemDecoration(
        color: message.color,
        elevation: elevation,
        dateTime: message.dateTime,
        child: Text(message.content));
  }
}
