import 'package:info_keeper/model/types/all.dart';

class StorageFile {
  AllType type;
  String? name;
  String? data;
  List? history;
  bool dublicated;
  bool link;
  bool animate;
  bool pinned;
  bool isLocked;
  String pathToImage;

  StorageFile(
      {this.type = AllType.storageFile,
      this.name,
      this.data,
      this.link = false,
      this.dublicated = false,
      this.pinned = false,
      this.pathToImage = '',
      this.history,
      this.isLocked = false,
      this.animate = false});

  StorageFile.fromJson(Map<String, dynamic> json)
      : type = AllType.values.elementAt(json['type']),
        name = json['name'],
        link = json['link'],
        dublicated = json['dublicated'],
        pinned = json['pinned'],
        data = json['data'],
        isLocked = json['isLocked'],
        history = json['history'],
        pathToImage = json['pathToImage'],
        animate = json['animate'];

  Map<String, dynamic> toJson() => {
        'type': type.index,
        'name': name,
        'link': link,
        'dublicated': dublicated,
        'pinned': pinned,
        'data': data,
        'history': history,
        'isLocked': isLocked,
        'animate': animate,
        'pathToImage': pathToImage
      };
}
