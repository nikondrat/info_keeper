import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/home.dart';
import 'package:info_keeper/model/types/home/todo/task.dart';

class Todo {
  HomeType type;
  RxList<Task>? tasks;

  Todo({
    this.type = HomeType.todo,
    this.tasks,
  });

  Todo.fromJson(Map<String, dynamic> json)
      : type = HomeType.values.elementAt(json['type']),
        tasks = (json['tasks'] as List<dynamic>)
            .map((e) => Task.fromJson(e))
            .toList()
            .obs;

  Map<String, dynamic> toJson() {
    return {
      'type': type.index,
      'tasks': tasks!.map((e) => e.toJson()).toList(),
    };
  }
}
