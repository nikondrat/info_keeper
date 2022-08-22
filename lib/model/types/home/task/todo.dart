import 'package:info_keeper/model/controller.dart';

class Todo {
  String title;
  bool isCompleted;
  Todo({required this.title, this.isCompleted = false});

  Todo copyWith({required int index, String? title, bool? isCompleted}) {
    Todo todo = Todo(
        title: title ?? this.title,
        isCompleted: isCompleted ?? this.isCompleted);
    return Controller
        .to
        .all[Controller.to.selectedFolder.value]
        .childrens[Controller.to.selectedElementIndex.value]
        .child
        .todos[index] = todo;
  }

  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? '',
        isCompleted = json['isCompleted'] ?? false;

  Map<String, dynamic> toJson() => {
        'title': title,
        'isCompleted': isCompleted,
      };
}
