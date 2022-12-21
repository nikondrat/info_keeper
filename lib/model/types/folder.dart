import 'package:get/get.dart';
import 'package:info_keeper/model/types/home_item.dart';

class Folder {
  String name;
  RxList<HomeItem> childrens;
  Folder({
    required this.name,
    required this.childrens,
  });

  // List getChildrens({bool isVault = false}) {
  //   List list = [];

  //   for (int i = 0; i < childrens.length; i++) {
  //     if (isVault) {
  //       if (childrens[i].isLocked) {
  //         list.add(childrens[i]);
  //       }
  //     } else {
  //       if (!childrens[i].isLocked) {
  //         list.add(childrens[i]);
  //       }
  //     }
  //   }
  //   return list;
  // }

  Folder.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        childrens = (json['childrens'] as List)
            .map((e) => HomeItem.fromJson(e))
            .toList()
            .obs;

  // HomeItem.fromJson(json['childrens'])
  //   childrens = (json['childrens'] as List<dynamic>)
  //       .map<dynamic>((dynamic e) {
  //         switch (AllType.values.elementAt(e['type'])) {
  //           case AllType.chat:
  //             return Chat.fromJson(e);
  //           case AllType.storageFile:
  //             return StorageFile.fromJson(e);
  //           case AllType.todo:
  //             return Todo.fromJson(e);
  //           case AllType.audioNote:
  //             return AudioNote.fromJson(e);
  //           case AllType.chatFile:
  //             break;
  //           case AllType.chatMessage:
  //             break;
  //           case AllType.chatVoice:
  //             break;
  //           case AllType.chatImage:
  //             break;
  //         }
  //       })
  //       .toList()
  //       .obs;

  Map<String, dynamic> toJson() => {
        'name': name,
        'childrens': childrens.map((e) => e.toJson()).toList(),
      };
}
