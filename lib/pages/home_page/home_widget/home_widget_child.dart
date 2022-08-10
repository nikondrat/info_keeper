import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/pages/home_page/home_widget/type/home_widget_audio_note.dart';
import 'package:info_keeper/pages/home_page/home_widget/type/home_widget_chat.dart';
import 'package:info_keeper/pages/home_page/home_widget/type/home_widget_storage_file.dart';
import 'package:info_keeper/pages/home_page/home_widget/type/home_widget_todo.dart';

class HomeWidgetChild extends StatelessWidget {
  final dynamic value;
  final String term;
  final int index;
  final bool? isVault;
  final bool? isTrash;
  const HomeWidgetChild(
      {Key? key,
      required this.value,
      required this.index,
      this.term = '',
      this.isTrash,
      this.isVault})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (value.type) {
      case AllType.chat:
        return HomeWidgetChat(
          index: index,
          term: term,
          isTrash: isTrash,
        );
      case AllType.storageFile:
        return HomeWidgetStorageFile(
            storageFile: value, index: index, term: term);
      case AllType.todo:
        return HomeWidgetTodo(todo: value, index: index, term: term);
      case AllType.audioNote:
        return HomeWidgetAudioNote(audioNote: value, index: index, term: term);
      default:
        return Container();
    }
  }
}
