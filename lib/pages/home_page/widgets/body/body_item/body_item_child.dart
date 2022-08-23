import 'package:flutter/cupertino.dart';
import 'package:info_keeper/model/types/home/home.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/item_type/audio_note_item.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/item_type/chat_item.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/item_type/storage_file_item.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/item_type/task_item.dart';

class HomeBodyItemChild extends StatelessWidget {
  final int homeItemIndex;
  final HomeItem homeItem;
  final String term;
  const HomeBodyItemChild(
      {Key? key,
      required this.homeItemIndex,
      required this.homeItem,
      required this.term})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return TodoItem(
    //     homeItemIndex: homeItemIndex, homeItem: homeItem, term: term);
    switch (homeItem.child.type) {
      case HomeType.chat:
        return ChatItem(index: homeItemIndex, homeItem: homeItem, term: term);
      case HomeType.storageFile:
        return StorageFileItem(
            index: homeItemIndex, homeItem: homeItem, term: term);
      case HomeType.task:
        return TodoItem(
            homeItemIndex: homeItemIndex, homeItem: homeItem, term: term);
      case HomeType.audioNote:
        return AudioNoteItem(homeItem: homeItem, term: term);
      default:
        return const SizedBox();
    }
  }
}
