import 'package:info_keeper/model/types/all.dart';

class TrashElement {
  AllType type;
  dynamic element;

  TrashElement({
    required this.type,
    required this.element,
  });

  TrashElement.fromJson(Map<String, dynamic> json)
      : type = AllType.values.elementAt(json['type']),
        element = json['element'];

  Map<String, dynamic> toJson() => {
        'type': type.index,
        'element': element,
      };
}
