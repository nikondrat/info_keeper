import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/model/types/home_item.dart';

class TrashItem {
  dynamic child;
  bool isMessage;
  TrashItem({required this.child, this.isMessage = false});

  static dynamic childFromJson(Map<String, dynamic> json) {
    if (json['isMessage']) {
      return Message.fromJson(json['child']);
    } else {
      return HomeItem.fromJson(json['child']);
    }
  }

  TrashItem.fromJson(Map<String, dynamic> json)
      : isMessage = json['isMessage'],
        child = childFromJson(json);

  Map<String, dynamic> toJson() =>
      {'child': child.toJson(), 'isMessage': isMessage};
}
