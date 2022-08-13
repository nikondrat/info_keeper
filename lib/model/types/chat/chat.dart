import 'package:get/get.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/chat/chat_file.dart';
import 'package:info_keeper/model/types/chat/chat_image.dart';
import 'package:info_keeper/model/types/chat/chat_voice.dart';
import 'package:info_keeper/model/types/chat/message.dart';
import 'package:info_keeper/model/types/location_element.dart';

class Chat {
  AllType type;
  LocationElement? location;
  String? name;
  bool animate;
  bool dublicated;
  bool link;
  bool pinned;
  bool isLocked;
  RxList? messages;
  RxList? favorites;
  RxList? pinnedMessages;
  String pathToImage;

  Chat(
      {this.type = AllType.chat,
      this.location,
      this.name,
      this.animate = false,
      this.pinned = false,
      this.dublicated = false,
      this.link = false,
      this.isLocked = false,
      this.favorites,
      this.pinnedMessages,
      this.pathToImage = '',
      this.messages});

  Chat.fromJson(Map<String, dynamic> json)
      : type = AllType.values.elementAt(json['type']),
        location = LocationElement.fromJson(json['location']),
        name = json['name'],
        link = json['link'],
        isLocked = json['isLocked'],
        pinned = json['pinned'],
        dublicated = json['dublicated'],
        animate = json['animate'],
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
      'location': location!.toJson(),
      'name': name,
      'link': link,
      'pinned': pinned,
      'animate': animate,
      'isLocked': isLocked,
      'dublicated': dublicated,
      'pathToImage': pathToImage,
      'pinnedMessages': pinnedMessages!.map((e) => e.toJson()).toList(),
      'messages': messages!.map((e) => e.toJson()).toList(),
      'favorites': favorites!.map((e) => e.toJson()).toList(),
    };
  }
}
