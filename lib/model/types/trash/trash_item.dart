import 'package:info_keeper/model/types/home/audio/audio_note.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/model/types/home/home.dart';
import 'package:info_keeper/model/types/home/storage_file/storage_file.dart';
import 'package:info_keeper/model/types/home/task/task.dart';

class TrashItem {
  dynamic child;
  bool isMessage;
  TrashItem({required this.child, this.isMessage = false});

  static dynamic childFromJson(Map<String, dynamic> json) {
    if (json['isMessage']) {
      return Message.fromJson(json['child']);
    } else {
      switch (HomeType.values.elementAt(json['child']['type'])) {
        case HomeType.chat:
          return Chat.fromJson(json);
        case HomeType.storageFile:
          return StorageFile.fromJson(json);
        case HomeType.task:
          return Task.fromJson(json);
        case HomeType.audioNote:
          return AudioNote.fromJson(json);
        default:
      }
    }
  }

  TrashItem.fromJson(Map<String, dynamic> json)
      : isMessage = json['isMessage'],
        child = childFromJson(json);

  Map<String, dynamic> toJson() =>
      {'child': child.toJson(), 'isMessage': isMessage};
}
