class Task {
  String title;
  bool taskIsCompleted;
  Task({required this.title, this.taskIsCompleted = false});

  Task.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        taskIsCompleted = json['taskIsCompleted'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'taskIsCompleted': taskIsCompleted,
      };
}
