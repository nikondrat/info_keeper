import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/all.dart';
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
              switch (AllType.values.elementAt(e['type'])) {
                case AllType.chatMessage:
                  return Message.fromJson(e);
                case AllType.chatVoice:
                  return ChatVoice.fromJson(e);
                case AllType.chatImage:
                  return ChatImage.fromJson(e);
                case AllType.chatFile:
                  return ChatFile.fromJson(e);
                case AllType.chat:
                  break;
                case AllType.storageFile:
                  break;
                case AllType.todo:
                  break;
                case AllType.audioNote:
                  break;
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
