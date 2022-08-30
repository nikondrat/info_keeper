import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/items/message.dart';

class ChatItem extends StatelessWidget {
  final int index;
  final dynamic message;
  final bool drag;
  const ChatItem(
      {Key? key, required this.index, required this.message, this.drag = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    message.location.itemIndex = index;

    switch (message.type) {
      case AllType.chatMessage:
        return MessageWidget(key: Key('$index'), message: message, drag: drag);
      case AllType.chatVoice:
        return Text('hello');
      default:
        return const SizedBox();
    }
  }
}
