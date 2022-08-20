import 'package:info_keeper/model/types/home/home.dart';

class StorageFile {
  HomeType type;
  String data;
  List? history;
  String pathToImage;

  StorageFile({
    this.type = HomeType.storageFile,
    this.data = '',
    this.pathToImage = '',
    this.history,
  });

  StorageFile.fromJson(Map<String, dynamic> json)
      : type = HomeType.values.elementAt(json['type']),
        data = json['data'],
        history = json['history'],
        pathToImage = json['pathToImage'];

  Map<String, dynamic> toJson() => {
        'type': type.index,
        'data': data,
        'history': history,
        'pathToImage': pathToImage
      };
}
