import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/item_location.dart';

class ChatVoice {
  String name;
  String path;
  AllType type;
  ItemLocation location;
  DateTime dateTime;
  Codec codec;
  bool isLocked;
  bool isUnlocked;

  ChatVoice(
      {this.name = '',
      required this.path,
      this.type = AllType.chatVoice,
      required this.location,
      this.isLocked = false,
      this.isUnlocked = false,
      this.codec = Codec.aacADTS,
      required this.dateTime});

  ChatVoice copyWith({
    String? path,
    RxBool? isPlay,
  }) {
    ChatVoice voice = ChatVoice(
        path: path ?? this.path, location: location, dateTime: dateTime);
    return Controller.to.all[location.inDirectory].childrens[location.index]
        .child.messages[location.itemIndex] = voice;
  }

  ChatVoice.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = AllType.values.elementAt(json['type']),
        location = ItemLocation.fromJson(json['location']),
        dateTime = DateTime.parse(json['dateTime']),
        isLocked = json['isLocked'],
        isUnlocked = json['isUnlocked'],
        codec = Codec.values.elementAt(json['codec']),
        path = json['path'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type.index,
        'location': location.toJson(),
        'dateTime': dateTime.toString(),
        'isLocked': isLocked,
        'isUnlocked': isUnlocked,
        'path': path,
        'codec': codec.index
      };
}
