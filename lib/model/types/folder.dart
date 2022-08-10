import 'package:get/get.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/audio_note.dart';
import 'package:info_keeper/model/types/chat/chat.dart';
import 'package:info_keeper/model/types/storage_file.dart';
import 'package:info_keeper/model/types/todo.dart';

class Folder {
  String directoryName;
  RxList<dynamic> directoryChildrens;
  Folder({
    required this.directoryName,
    required this.directoryChildrens,
  });

  Folder.fromJson(Map<String, dynamic> json)
      : directoryName = json['directoryName'],
        directoryChildrens = (json['directoryChildrens'] as List<dynamic>)
            .map<dynamic>((dynamic e) {
              switch (AllType.values.elementAt(e['type'])) {
                case AllType.chat:
                  return Chat.fromJson(e);
                case AllType.storageFile:
                  return StorageFile.fromJson(e);
                case AllType.todo:
                  return Todo.fromJson(e);
                case AllType.audioNote:
                  return AudioNote.fromJson(e);
                case AllType.chatMessage:
                  break;
                case AllType.chatFile:
                  break;
                case AllType.chatVoice:
                  break;
                case AllType.chatImage:
                  break;
              }
            })
            .toList()
            .obs;

  Map<String, dynamic> toJson() => {
        'directoryName': directoryName,
        'directoryChildrens':
            directoryChildrens.map((e) => e.toJson()).toList(),
      };
}
