import 'package:flutter/cupertino.dart';
import 'package:info_keeper/model/types/home/home.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/item_type/audio_note_item.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/item_type/chat_item.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/item_type/storage_file_item.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/item_type/todo_item.dart';

class HomeBodyItemChild extends StatelessWidget {
  final HomeItem homeItem;
  const HomeBodyItemChild({Key? key, required this.homeItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (homeItem.child.type as HomeType) {
      case HomeType.chat:
        return ChatItem(homeItem: homeItem);
      case HomeType.storageFile:
        return StorageFileItem(homeItem: homeItem);
      case HomeType.todo:
        return TodoItem(homeItem: homeItem);
      case HomeType.audioNote:
        return AudioNoteItem(homeItem: homeItem);
      default:
        return Container(
          child: Text('hello'),
        );
    }
  }
}
