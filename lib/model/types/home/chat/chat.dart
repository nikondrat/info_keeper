import 'package:get/get.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/home/chat/chat_file.dart';
import 'package:info_keeper/model/types/home/chat/chat_image.dart';
import 'package:info_keeper/model/types/home/chat/chat_voice.dart';
import 'package:info_keeper/model/types/home/chat/message.dart';
import 'package:info_keeper/model/types/home/home.dart';

class Chat {
  HomeType type;

  RxList? messages;
  RxList? favorites;
  RxList? pinnedMessages;
  String pathToImage;

  Chat(
      {this.type = HomeType.chat,
      this.favorites,
      this.pinnedMessages,
      this.pathToImage = '',
      this.messages});

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
        pinnedMessages = (json['pinnedMessages'] as List<dynamic>)
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
        pathToImage = json['pathToImage'],
        favorites = (json['favorites'] as List<dynamic>)
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
            .obs;

  Map<String, dynamic> toJson() {
    return {
      'type': type.index,
      'pathToImage': pathToImage,
      'pinnedMessages': pinnedMessages!.map((e) => e.toJson()).toList(),
      'messages': messages!.map((e) => e.toJson()).toList(),
      'favorites': favorites!.map((e) => e.toJson()).toList(),
    };
  }
}
