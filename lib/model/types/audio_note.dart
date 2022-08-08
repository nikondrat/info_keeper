import 'package:info_keeper/model/types/all.dart';

class AudioNote {
  AllType type;
  String? name;
  String? path;
  bool pinned;
  bool animate;
  bool dublicated;
  bool link;
  bool isLocked;

  AudioNote(
      {this.type = AllType.audioNote,
      this.name,
      this.path,
      this.pinned = false,
      this.dublicated = false,
      this.animate = false,
      this.isLocked = false,
      this.link = false});

  AudioNote.fromJson(Map<String, dynamic> json)
      : type = AllType.values.elementAt(json['type']),
        name = json['name'],
        path = json['path'],
        pinned = json['pinned'],
        dublicated = json['dublicated'],
        isLocked = json['isLocked'],
        animate = json['animate'],
        link = json['link'];

  Map<String, dynamic> toJson() => {
        'type': type.index,
        'name': name,
        'path': path,
        'isLocked': isLocked,
        'animate': animate,
        'dublicated': dublicated,
        'pinned': pinned,
        'link': link
      };
}
