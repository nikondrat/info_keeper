import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/reorderable_body.dart';

class ChatBody extends StatelessWidget {
  final Chat chat;
  const ChatBody({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
        offset: Offset(0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: ChatReorderableBody(chat: chat));
  }
}
