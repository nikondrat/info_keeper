import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/body_with_time.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/reorderable_body.dart';

class ChatBody extends StatelessWidget {
  final Chat chat;
  final RxBool showDate;
  const ChatBody({Key? key, required this.chat, required this.showDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
        offset: Offset(0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: showDate.value
            ? ChatBodyWithTime(chat: chat)
            : ChatReorderableBody(chat: chat));
  }
}
