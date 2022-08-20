import 'package:info_keeper/model/types/home/audio/audio_note.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/home.dart';
import 'package:info_keeper/model/types/home/storage_file/storage_file.dart';
import 'package:info_keeper/model/types/home/todo/todo.dart';
import 'package:info_keeper/model/types/item_location.dart';

class HomeItem {
  String name;
  dynamic child;
  bool isLink;
  bool isLocked;
  bool isPinned;
  bool isAnimated;
  bool isDublicated;
  ItemLocation location;

  HomeItem({
    this.name = '',
    required this.child,
    this.isLink = false,
    this.isLocked = false,
    this.isPinned = false,
    this.isAnimated = false,
    this.isDublicated = false,
    required this.location,
  });

  void pin() {
    isPinned = !isPinned;
  }

  void animate() {
    isAnimated = !isAnimated;
  }

  HomeItem.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        child = Todo.fromJson(json['child']),

        // child = json['child'].values.map((e) {
        //   // child = (json['child']).values.map((e) {
        //   switch (HomeType.values.elementAt(e['type'])) {
        //     case HomeType.chat:
        //       return Chat.fromJson(e);
        //     case HomeType.storageFile:
        //       return StorageFile.fromJson(e);
        //     case HomeType.todo:
        //       return Todo.fromJson(e);
        //     case HomeType.audioNote:
        //       return AudioNote.fromJson(e);
        //     default:
        //   }
        // }),

        isLink = json['isLink'] ?? false,
        isLocked = json['isLocked'] ?? false,
        isPinned = json['isPinned'] ?? false,
        isAnimated = json['isAnimated'] ?? false,
        isDublicated = json['isDublicated'] ?? false,
        location = ItemLocation.fromJson(json['location']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'child': child.toJson(),
        'isLink': isLink,
        'isLocked': isLocked,
        'isPinned': isPinned,
        'isAnimated': isAnimated,
        'isDublicated': isDublicated,
        'location': location.toJson()
      };
}
