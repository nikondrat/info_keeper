import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home/todo/task.dart';
import 'package:info_keeper/pages/todo_page/widgets/todo_task.dart';
import 'package:get/get.dart';

class TodoPageBody extends StatelessWidget {
  final RxList<Task> tasks;
  const TodoPageBody({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Obx(
        () => ListView.builder(
            physics: const BouncingScrollPhysics(),
            reverse: true,
            itemCount: tasks.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return TodoPageTaskWidget(
                index: index,
                tasks: tasks,
              );
            }),
      ),
    );
  }
}
