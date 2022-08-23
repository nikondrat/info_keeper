import 'package:flutter_sound/flutter_sound.dart';
import 'package:info_keeper/model/types/home/home.dart';

class AudioNote {
  HomeType type;
  String? path;
  Codec codec;

  AudioNote(
      {this.type = HomeType.audioNote, this.path, this.codec = Codec.aacMP4});

  AudioNote.fromJson(Map<String, dynamic> json)
      : type = HomeType.values.elementAt(json['type']),
        codec = Codec.values.elementAt(json['codec']),
        path = json['path'];

  Map<String, dynamic> toJson() => {
        'type': type.index,
        'codec': codec.index,
        'path': path,
      };
}
