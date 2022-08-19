import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/location_element.dart';

// class StorageFile {
//   AllType type;
//   LocationElement? location;
//   String? name;
//   String? data;
//   List? history;
//   bool dublicated;
//   bool link;
//   bool animate;
//   bool pinned;
//   bool isLocked;
//   String pathToImage;

//   StorageFile(
//       {this.type = AllType.storageFile,
//       this.location,
//       this.name,
//       this.data,
//       this.link = false,
//       this.dublicated = false,
//       this.pinned = false,
//       this.pathToImage = '',
//       this.history,
//       this.isLocked = false,
//       this.animate = false});

//   StorageFile.fromJson(Map<String, dynamic> json)
//       : type = AllType.values.elementAt(json['type']),
//         location = LocationElement.fromJson(json['location']),
//         name = json['name'],
//         link = json['link'],
//         dublicated = json['dublicated'],
//         pinned = json['pinned'],
//         data = json['data'],
//         isLocked = json['isLocked'],
//         history = json['history'],
//         pathToImage = json['pathToImage'],
//         animate = json['animate'];

//   Map<String, dynamic> toJson() => {
//         'type': type.index,
//         'name': name,
//         'location': location!.toJson(),
//         'link': link,
//         'dublicated': dublicated,
//         'pinned': pinned,
//         'data': data,
//         'history': history,
//         'isLocked': isLocked,
//         'animate': animate,
//         'pathToImage': pathToImage
//       };
// }

class StorageFile {
  AllType type;
  LocationElement? location;
  String? name;
  String? data;
  List? history;
  bool dublicated;
  bool link;
  bool animate;
  bool isPinned;
  bool isLocked;
  String pathToImage;

  StorageFile(
      {this.type = AllType.storageFile,
      this.location,
      this.name,
      this.data,
      this.link = false,
      this.dublicated = false,
      this.isPinned = false,
      this.pathToImage = '',
      this.history,
      this.isLocked = false,
      this.animate = false});

  void pin() {
    isPinned = !isPinned;
  }

  StorageFile.fromJson(Map<String, dynamic> json)
      : type = AllType.values.elementAt(json['type']),
        location = LocationElement.fromJson(json['location']),
        name = json['name'],
        link = json['link'],
        dublicated = json['dublicated'],
        isPinned = json['pinned'],
        data = json['data'],
        isLocked = json['isLocked'],
        history = json['history'],
        pathToImage = json['pathToImage'],
        animate = json['animate'];

  Map<String, dynamic> toJson() => {
        'type': type.index,
        'name': name,
        'location': location!.toJson(),
        'link': link,
        'dublicated': dublicated,
        'pinned': isPinned,
        'data': data,
        'history': history,
        'isLocked': isLocked,
        'animate': animate,
        'pathToImage': pathToImage
      };
}
