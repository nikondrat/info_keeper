import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/item_location.dart';

class ChatImage {
  AllType type;
  ItemLocation location;
  String path;
  DateTime dateTime;
  bool isLocked;
  bool isUnlocked;

  ChatImage(
      {required this.path,
      required this.location,
      this.type = AllType.chatImage,
      this.isLocked = false,
      this.isUnlocked = false,
      required this.dateTime});

  ChatImage.fromJson(Map<String, dynamic> json)
      : type = AllType.values.elementAt(json['type']),
        location = ItemLocation.fromJson(json['location']),
        dateTime = DateTime.parse(json['dateTime']),
        isLocked = json['isLocked'],
        isUnlocked = json['isUnlocked'],
        path = json['path'];

  Map<String, dynamic> toJson() => {
        'type': type.index,
        'path': path,
        'location': location.toJson(),
        'isLocked': isLocked,
        'isUnlocked': isUnlocked,
        'dateTime': dateTime.toString()
      };
}
