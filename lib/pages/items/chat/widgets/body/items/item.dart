import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/items/message.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/items/voice.dart';

class ChatItem extends StatelessWidget {
  final int index;
  final dynamic message;
  final double elevation;
  const ChatItem(
      {Key? key,
      required this.index,
      this.elevation = 0,
      required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    message.location.itemIndex = index;

    switch (message.type) {
      case AllType.chatMessage:
        return MessageWidget(
            key: Key('$index'), message: message, elevation: elevation);
      case AllType.chatVoice:
        return ChatVoiceWidget(
            key: Key('$index'), voice: message, elevation: elevation);
      default:
        return const SizedBox();
    }
  }
}
