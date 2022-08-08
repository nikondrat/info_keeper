import 'package:info_keeper/model/types/chat/chat_type.dart';

class Message {
  int index;
  ChatType type;
  String title;
  String messageText;
  int selectedColorIndex;
  String dateTime;
  bool isFavorite;
  bool isSelected;
  bool isPinned;
  bool isLocked;
  List? history;

  Message(
      {required this.index,
      this.title = '',
      this.type = ChatType.chatMessage,
      required this.messageText,
      this.selectedColorIndex = 5,
      this.isFavorite = false,
      this.isSelected = false,
      this.isPinned = false,
      this.isLocked = false,
      this.history,
      required this.dateTime});

  Message.fromJson(Map<String, dynamic> json)
      : index = json['index'],
        type = ChatType.values.elementAt(json['type']),
        title = json['title'],
        messageText = json['messageText'],
        isSelected = json['isSelected'],
        isPinned = json['isPinned'],
        isLocked = json['isLocked'],
        selectedColorIndex = json['selectedColorIndex'],
        isFavorite = json['isFavorite'],
        history = (json['history'] as List<dynamic>)
            .map((e) => Message.fromJson(e))
            .toList(),
        dateTime = json['dateTime'];

  Map<String, dynamic> toJson() => {
        'index': index,
        'type': type.index,
        'title': title,
        'messageText': messageText,
        'selectedColorIndex': selectedColorIndex,
        'isFavorite': isFavorite,
        'isSelected': isSelected,
        'isPinned': isPinned,
        'isLocked': isLocked,
        'history': history!.map((e) => e.toJson()).toList(),
        'dateTime': dateTime
      };
}
