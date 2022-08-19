import 'package:get/get.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/location_element.dart';
import 'package:info_keeper/model/types/task.dart';

class Todo {
  AllType type;
  LocationElement? location;
  String? name;
  RxList<Task>? tasks;
  bool isPinned;
  bool animate;
  bool dublicated;
  bool link;
  bool isLocked;

  Todo(
      {this.type = AllType.todo,
      this.location,
      this.name,
      this.tasks,
      this.isPinned = false,
      this.dublicated = false,
      this.animate = false,
      this.isLocked = false,
      this.link = false});

  void pin() {
    isPinned = !isPinned;
  }

  Todo.fromJson(Map<String, dynamic> json)
      : type = AllType.values.elementAt(json['type']),
        location = LocationElement.fromJson(json['location']),
        name = json['name'],
        tasks = (json['tasks'] as List<dynamic>)
            .map((e) => Task.fromJson(e))
            .toList()
            .obs,
        isPinned = json['pinned'],
        isLocked = json['isLocked'],
        dublicated = json['dublicated'],
        animate = json['animate'],
        link = json['link'];

  Map<String, dynamic> toJson() {
    return {
      'type': type.index,
      'name': name,
      'location': location!.toJson(),
      'tasks': tasks!.map((e) => e.toJson()).toList(),
      'pinned': isPinned,
      'isLocked': isLocked,
      'animate': animate,
      'dublicated': dublicated,
      'link': link
    };
  }
}
