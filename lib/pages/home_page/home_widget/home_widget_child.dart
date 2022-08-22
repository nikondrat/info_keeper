import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/home_widget/type/home_widget_storage_file.dart';

class HomeWidgetChild extends StatelessWidget {
  final HomeItem homeItem;
  final String term;
  final int index;
  final bool? isVault;
  final bool? isTrash;
  const HomeWidgetChild(
      {Key? key,
      required this.homeItem,
      required this.index,
      this.term = '',
      this.isTrash,
      this.isVault})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeWidgetStorageFile(homeItem: homeItem, index: index);
    // switch (value.type) {
    //   case AllType.chat:
    //     return HomeWidgetChat(
    //       index: index,
    //       term: term,
    //       isTrash: isTrash,
    //     );
    //   case AllType.storageFile:
    //     return HomeWidgetStorageFile(
    //         isTrash: isTrash, homeItem: value, index: index, term: term);
    //   case AllType.todo:
    //     return HomeWidgetTodo(
    //         isTrash: isTrash, todo: value, index: index, term: term);
    //   case AllType.audioNote:
    //     return HomeWidgetAudioNote(
    //         isTrash: isTrash, audioNote: value, index: index, term: term);
    //   default:
    //     return Container();
    // }
  }
}
