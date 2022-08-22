import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home/task/task.dart';
import 'package:get/get.dart';
import 'package:info_keeper/pages/task_page/widgets/todo.dart';

class TaskPageBody extends StatelessWidget {
  final Task task;
  const TaskPageBody({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: task.todos.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return TodoWidget(task: task, index: index);
          }),
    );
  }
}
