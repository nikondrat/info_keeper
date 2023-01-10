import 'package:info_keeper/app/models/home/home_type.dart';

class HomeItem {
  int index;
  dynamic child;
  String title;
  HomeItemValues values;

  HomeItem(
      {required this.index,
      required this.title,
      required this.child,
      required this.values});

  static dynamic _childFromJson(Map<String, dynamic> json) {
    switch (HomeItemType.values.elementAt(json['type'])) {
      case HomeItemType.chat:
      case HomeItemType.storageFile:
      case HomeItemType.task:
      case HomeItemType.audioNote:
      default:
    }
  }

  HomeItem.fromJson(Map<String, dynamic> json)
      : index = json['index'] ?? 0,
        title = json['title'] ?? '',
        child = _childFromJson(json['child']),
        values = json['values'] ?? HomeItemValues();

  Map<String, dynamic> toJson() => {
        'index': index,
        'title': title,
        'child': child.toJson(),
        'values': values.toJson()
      };
}

class HomeItemValues {
  bool isLink;
  bool isLocked;
  bool isPinned;
  bool isAnimated;
  bool isDublicated;
  HomeItemValues(
      {this.isLink = false,
      this.isLocked = false,
      this.isPinned = false,
      this.isAnimated = false,
      this.isDublicated = false});

  void setItLink(bool isLink) {
    this.isLink = isLink;
  }

  void setItLocked(bool isLocked) {
    this.isLocked = isLocked;
  }

  void setItPinned(bool isPinned) {
    this.isPinned = isPinned;
  }

  void setItAnimated(bool isAnimated) {
    this.isAnimated = isAnimated;
  }

  void setItDublicated(bool isDublicated) {
    this.isDublicated = isDublicated;
  }

  HomeItemValues.fromJson(Map<String, dynamic> json)
      : isLink = json['isLink'] ?? false,
        isLocked = json['isLocked'] ?? false,
        isPinned = json['isPinned'] ?? false,
        isAnimated = json['isAnimated'] ?? false,
        isDublicated = json['isDublicated'] ?? false;

  Map<String, dynamic> toJson() => {
        'isLink': isLink,
        'isLocked': isLocked,
        'isPinned': isPinned,
        'isAnimated': isAnimated,
        'isDublicated': isDublicated,
      };
}
