import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/location_element.dart';

class ChatVoice {
  AllType type;
  LocationElement location;
  String path;
  String dateTime;
  bool isLocked;
  bool isUnlocked;

  ChatVoice(
      {required this.path,
      this.type = AllType.chatVoice,
      required this.location,
      this.isLocked = false,
      this.isUnlocked = false,
      required this.dateTime});

  ChatVoice.fromJson(Map<String, dynamic> json)
      : type = AllType.values.elementAt(json['type']),
        location = LocationElement.fromJson(json['location']),
        dateTime = json['dateTime'],
        isLocked = json['isLocked'],
        isUnlocked = json['isUnlocked'],
        path = json['path'];

  Map<String, dynamic> toJson() => {
        'type': type.index,
        'location': location.toJson(),
        'dateTime': dateTime,
        'isLocked': isLocked,
        'isUnlocked': isUnlocked,
        'path': path,
      };
}
