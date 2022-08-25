import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/home.dart';
import 'package:info_keeper/model/types/home/task/todo.dart';

class Task {
  HomeType type;
  RxList<Todo> todos;

  Task({
    this.type = HomeType.task,
    required this.todos,
  });

  Task copyWith({RxList<Todo>? todos}) {
    Task task = Task(todos: todos ?? this.todos);
    return Controller.to.all[Controller.to.selectedFolder.value]
        .childrens[Controller.to.selectedElementIndex.value].child = task;
  }

  Task.fromJson(Map<String, dynamic> json)
      : type = HomeType.values.elementAt(json['type']),
        todos = (json['todos'] as List<dynamic>)
            .map((e) => Todo.fromJson(e))
            .toList()
            .obs;

  Map<String, dynamic> toJson() {
    return {
      'type': type.index,
      'todos': todos.map((e) => e.toJson()).toList(),
    };
  }
}
