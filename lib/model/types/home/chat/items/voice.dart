import 'package:flutter_sound/flutter_sound.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/item_location.dart';

class ChatVoice {
  String name;
  String path;
  AllType type;
  ItemLocation location;
  String dateTime;
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

  ChatVoice.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = AllType.values.elementAt(json['type']),
        location = ItemLocation.fromJson(json['location']),
        dateTime = json['dateTime'],
        isLocked = json['isLocked'],
        isUnlocked = json['isUnlocked'],
        codec = Codec.values.elementAt(json['codec']),
        path = json['path'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type.index,
        'location': location.toJson(),
        'dateTime': dateTime,
        'isLocked': isLocked,
        'isUnlocked': isUnlocked,
        'path': path,
        'codec': codec.index
      };
}
