import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/item_location.dart';
import 'package:info_keeper/themes/default/default.dart';

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
  List? history;

  // write an int variable with the length of the list
  // because if i recover the message
  // it recover at last position writed in location
  // but if i adding new messages
  // message recovered to old position

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
      this.isUnlocked = false,
      this.history,
      required this.dateTime}) {
    color = defaultColor;
  }

  Message.fromJson(Map<String, dynamic> json)
      : type = AllType.values.elementAt(json['type']),
        location = ItemLocation.fromJson(json['location']),
        title = json['title'],
        content = json['content'],
        isSelected = json['isSelected'],
        isPinned = json['isPinned'],
        isLocked = json['isLocked'],
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
        'isSelected': isSelected,
        'isUnlocked': isUnlocked,
        'isPinned': isPinned,
        'isLocked': isLocked,
        'history': history,
        'dateTime': dateTime.toString()
      };
}
