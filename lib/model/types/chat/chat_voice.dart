import 'package:info_keeper/model/types/chat/chat_type.dart';

class ChatVoice {
  ChatType type;
  String path;
  String dateTime;

  ChatVoice(
      {required this.path,
      this.type = ChatType.chatVoice,
      required this.dateTime});

  ChatVoice.fromJson(Map<String, dynamic> json)
      : type = ChatType.values.elementAt(json['type']),
        dateTime = json['dateTime'],
        path = json['path'];

  Map<String, dynamic> toJson() => {
        'type': type.index,
        'dateTime': dateTime,
        'path': path,
      };
}
