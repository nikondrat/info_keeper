import 'package:get/get.dart';

class Task {
  String title;
  RxBool isCompleted;
  Task({required this.title, required this.isCompleted});

  void completed() {
    isCompleted.value = !isCompleted.value;
  }

  Task.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? '',
        isCompleted = json['isCompleted'] ?? false.obs;

  Map<String, dynamic> toJson() => {
        'title': title,
        'isCompleted': isCompleted,
      };
}
