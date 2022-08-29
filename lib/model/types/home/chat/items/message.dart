import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/item_location.dart';

class Message {
  ItemLocation location;
  AllType type;
  String title;
  String content;
  int color;
  DateTime dateTime;

  bool isFavorite;
  bool isSelected;
  bool isPinned;
  bool isLocked;
  bool isUnlocked;
  bool isCollapsed;
  List? history;

  Message(
      {required this.location,
      this.title = '',
      this.type = AllType.chatMessage,
      required this.content,
      this.color = 5,
      this.isFavorite = false,
      this.isSelected = false,
      this.isPinned = false,
      this.isLocked = false,
      this.isCollapsed = false,
      this.isUnlocked = false,
      this.history,
      required this.dateTime});

  Message.fromJson(Map<String, dynamic> json)
      : type = AllType.values.elementAt(json['type']),
        location = ItemLocation.fromJson(json['location']),
        title = json['title'],
        content = json['content'],
        isSelected = json['isSelected'],
        isPinned = json['isPinned'],
        isLocked = json['isLocked'],
        isCollapsed = json['isCollapsed'],
        isUnlocked = json['isUnlocked'],
        color = json['color'],
        isFavorite = json['isFavorite'],
        history = json['history'],
        dateTime = DateTime.parse(json['dateTime']);

  Map<String, dynamic> toJson() => {
        'type': type.index,
        'location': location.toJson(),
        'title': title,
        'content': content,
        'color': color,
        'isFavorite': isFavorite,
        'isCollapsed': isCollapsed,
        'isSelected': isSelected,
        'isUnlocked': isUnlocked,
        'isPinned': isPinned,
        'isLocked': isLocked,
        'history': history,
        'dateTime': dateTime.toString()
      };
}
