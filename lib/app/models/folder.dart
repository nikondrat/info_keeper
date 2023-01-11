import 'package:info_keeper/app/models/home/home_item.dart';

class Folder {
  String title;
  List<HomeItem> children;

  Folder({
    required this.title,
    required this.children,
  });

  Folder.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? '',
        children =
            (json['children'] ?? []).map((e) => HomeItem.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
        'title': title,
        'children': children.map((e) => e.toJson()).toList(),
      };
}
