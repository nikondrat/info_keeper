import 'package:info_keeper/model/types/home/home.dart';

class AudioNote {
  HomeType type;
  String? path;

  AudioNote({
    this.type = HomeType.audioNote,
    this.path,
  });

  AudioNote.fromJson(Map<String, dynamic> json)
      : type = HomeType.values.elementAt(json['type']),
        path = json['path'];

  Map<String, dynamic> toJson() => {
        'type': type.index,
        'path': path,
      };
}
