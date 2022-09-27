import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/chat_type.dart';
import 'package:info_keeper/model/types/home/chat/items/file.dart';
import 'package:info_keeper/model/types/home/chat/items/image.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/model/types/home/chat/items/voice.dart';
import 'package:info_keeper/model/types/home/home.dart';

class Chat {
  HomeType type;
  RxList messages;
  String backgroundImage;

  Chat(
      {this.type = HomeType.chat,
      this.backgroundImage = '',
      required this.messages});

  copyWith({RxList? messages, String? backgroundImage}) {
    Chat chat = Chat(
        messages: messages ?? this.messages,
        backgroundImage: backgroundImage ?? this.backgroundImage);

    Controller.to.all[Controller.to.selectedFolder.value]
        .childrens[Controller.to.selectedElementIndex.value].child = chat;
    return Controller.to.setData();
  }

  Chat.fromJson(Map<String, dynamic> json)
      : type = HomeType.values.elementAt(json['type']),
        messages = (json['messages'] as List<dynamic>)
            .map<dynamic>((dynamic e) {
              switch (ChatType.values.elementAt(e['type'])) {
                case ChatType.message:
                  return Message.fromJson(e);
                case ChatType.voice:
                  return ChatVoice.fromJson(e);
                case ChatType.image:
                  return ChatImage.fromJson(e);
                case ChatType.file:
                  return ChatFile.fromJson(e);
              }
            })
            .toList()
            .obs,
        backgroundImage = json['backgroundImage'];

  Map<String, dynamic> toJson() {
    return {
      'type': type.index,
      'backgroundImage': backgroundImage,
      'messages': messages.map((e) => e.toJson()).toList(),
    };
  }
}
