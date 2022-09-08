import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/items/voice.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/items/voice.dart';

class ChatMediaSounds extends StatelessWidget {
  final Chat chat;
  const ChatMediaSounds({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    List<ChatVoice> voices = [];

    for (int i = 0; i < chat.messages.length; i++) {
      if (chat.messages[i].type == AllType.chatVoice) {
        voices.insert(0, chat.messages[i]);
      }
    }

    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: voices.length,
        itemBuilder: (context, index) => ChatVoiceWidget(voice: voices[index]));
  }
}
