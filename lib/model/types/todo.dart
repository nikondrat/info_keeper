import 'package:get/get.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/task.dart';

class Todo {
  AllType type;
  String? name;
  RxList<Task>? tasks;
  bool pinned;
  bool animate;
  bool dublicated;
  bool link;
  bool isLocked;

  Todo(
      {this.type = AllType.todo,
      this.name,
      this.tasks,
      this.pinned = false,
      this.dublicated = false,
      this.animate = false,
      this.isLocked = false,
      this.link = false});

  Todo.fromJson(Map<String, dynamic> json)
      : type = AllType.values.elementAt(json['type']),
        name = json['name'],
        tasks = (json['tasks'] as List<dynamic>)
            .map((e) => Task.fromJson(e))
            .toList()
            .obs,
        pinned = json['pinned'],
        isLocked = json['isLocked'],
        dublicated = json['dublicated'],
        animate = json['animate'],
        link = json['link'];

  Map<String, dynamic> toJson() {
    return {
      'type': type.index,
      'name': name,
      'tasks': tasks!.map((e) => e.toJson()).toList(),
      'pinned': pinned,
      'isLocked': isLocked,
      'animate': animate,
      'dublicated': dublicated,
      'link': link
    };
  }
}
