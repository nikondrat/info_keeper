import 'package:info_keeper/model/types/item_location.dart';

class HomeItem {
  String name;
  dynamic child;
  bool isLink;
  bool isLocked;
  bool isPinned;
  bool isAnimated;
  bool isDublicated;
  ItemLocation location;

  HomeItem({
    this.name = '',
    required this.child,
    this.isLink = false,
    this.isLocked = false,
    this.isPinned = false,
    this.isAnimated = false,
    this.isDublicated = false,
    required this.location,
  });

  void pin() {
    isPinned = !isPinned;
  }

  void animate() {
    isAnimated = !isAnimated;
  }

  HomeItem.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        child = json['item'],
        isLink = json['isLink'] ?? false,
        isLocked = json['isLocked'] ?? false,
        isPinned = json['isPinned'] ?? false,
        isAnimated = json['isAnimated'] ?? false,
        isDublicated = json['isDublicated'] ?? false,
        location = json['location'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'item': child,
        'isLink': isLink,
        'isLocked': isLocked,
        'isPinned': isPinned,
        'isAnimated': isAnimated,
        'isDublicated': isDublicated,
        'location': location
      };
}
