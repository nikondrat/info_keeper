import 'package:info_keeper/model/types/chat/chat_type.dart';

class ChatImage {
  ChatType type;
  String path;
  String dateTime;

  ChatImage(
      {required this.path,
      this.type = ChatType.chatImage,
      required this.dateTime});

  ChatImage.fromJson(Map<String, dynamic> json)
      : type = ChatType.values.elementAt(json['type']),
        dateTime = json['dateTime'],
        path = json['path'];

  Map<String, dynamic> toJson() =>
      {'type': type.index, 'path': path, 'dateTime': dateTime};
}
