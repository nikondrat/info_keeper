import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home/chat/old_chat.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/reorderable_body.dart';

class ChatBody extends StatelessWidget {
  final ChatItem chat;
  const ChatBody({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChatReorderableBody(chat: chat);
  }
}
