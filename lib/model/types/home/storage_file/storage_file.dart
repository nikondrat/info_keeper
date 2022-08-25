import 'package:info_keeper/model/controller.dart';
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

  StorageFile copyWith({String? data, List? history, String? pathToImage}) {
    StorageFile storageFile = StorageFile(
        data: data ?? this.data,
        history: history ?? this.history,
        pathToImage: pathToImage ?? this.pathToImage);
    return Controller
        .to
        .all[Controller.to.selectedFolder.value]
        .childrens[Controller.to.selectedElementIndex.value]
        .child = storageFile;
  }

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
