import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/item_location.dart';

class OldChatFile {
  String name;
  AllType type;
  ItemLocation location;
  String path;
  String dateTime;
  bool isLocked;
  bool isUnlocked;

  OldChatFile(
      {required this.name,
      required this.path,
      required this.location,
      this.type = AllType.chatFile,
      this.isLocked = false,
      this.isUnlocked = false,
      required this.dateTime});

  OldChatFile.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = AllType.values.elementAt(json['type']),
        location = ItemLocation.fromJson(json['location']),
        dateTime = json['dateTime'],
        isLocked = json['isLocked'],
        isUnlocked = json['isUnlocked'],
        path = json['path'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type.index,
        'path': path,
        'location': location.toJson(),
        'isLocked': isLocked,
        'isUnlocked': isUnlocked,
        'dateTime': dateTime
      };
}
