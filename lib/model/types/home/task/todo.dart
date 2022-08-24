import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/item_location.dart';

class Todo {
  String title;
  bool isCompleted;
  Todo({required this.title, this.isCompleted = false});

  Todo copyWith(
      {required ItemLocation location,
      required int index,
      String? title,
      bool? isCompleted}) {
    Todo todo = Todo(
        title: title ?? this.title,
        isCompleted: isCompleted ?? this.isCompleted);
    return Controller.to.all[location.inDirectory].childrens[location.index]
        .child.todos[index] = todo;
  }

  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? '',
        isCompleted = json['isCompleted'] ?? false;

  Map<String, dynamic> toJson() => {
        'title': title,
        'isCompleted': isCompleted,
      };
}
