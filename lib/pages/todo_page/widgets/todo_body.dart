import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home/todo/task.dart';
import 'package:info_keeper/pages/todo_page/todo_controller.dart';
import 'package:info_keeper/pages/todo_page/widgets/todo_task.dart';
import 'package:get/get.dart';

class TodoPageBody extends StatelessWidget {
  final RxList<Task> tasks;
  const TodoPageBody({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final TodoController todoController = Get.put(TodoController());

    RxList<Task> completedTasks =
        tasks.where((task) => task.isCompleted.value).toList().obs;
    RxList<Task> incompleteTasks =
        tasks.where((task) => !task.isCompleted.value).toList().obs;

    Widget incompleteTasksView = Obx(() => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: incompleteTasks.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return TodoPageTaskWidget(
            index: index,
            tasks: incompleteTasks,
          );
        }));

    Widget completedTasksView = Obx(() => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: completedTasks.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return TodoPageTaskWidget(
            index: index,
            tasks: completedTasks,
          );
        }));

    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: tasks.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return TodoPageTaskWidget(
            index: index,
            tasks: tasks,
          );
        });

    // return Obx(() => completedTasks.isNotEmpty
    //     ? ListView(
    //         shrinkWrap: true,
    //         children: [incompleteTasksView, completedTasksView],
    //       )
    //     : incompleteTasksView);
  }
}
