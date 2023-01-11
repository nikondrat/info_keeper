import 'package:info_keeper/app/models/home/home_item.dart';

class Chat {
  HomeItemType type;
  List children;

  Chat({this.type = HomeItemType.chat, required this.children});

  Chat.fromJson(Map<String, dynamic> json)
      : type = HomeItemType.values.elementAt(json['type']),
        children = json['children'];

  Map<String, dynamic> toJson() {
    return {'type': type.index, 'children': children};
  }
}
