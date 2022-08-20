import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:info_keeper/model/types/home/home.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/item_type/audio_note_item.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/item_type/chat_item.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/item_type/storage_file_item.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/item_type/todo_item.dart';

class HomeBodyItemChild extends StatelessWidget {
  final int index;
  final HomeItem homeItem;
  final String term;
  const HomeBodyItemChild(
      {Key? key,
      required this.index,
      required this.homeItem,
      required this.term})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TodoItem(index: index, homeItem: homeItem, term: term);
    // switch (homeItem.child.type) {
    //   case HomeType.chat:
    //     return ChatItem(index: index, homeItem: homeItem, term: term);
    //   case HomeType.storageFile:
    //     return StorageFileItem(index: index, homeItem: homeItem, term: term);
    //   case HomeType.todo:
    //     return TodoItem(index: index, homeItem: homeItem, term: term);
    //   case HomeType.audioNote:
    //     return AudioNoteItem(homeItem: homeItem, term: term);
    //   default:
    //     return const SizedBox();
    // }
  }
}
