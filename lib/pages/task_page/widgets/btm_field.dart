import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/task/task.dart';
import 'package:info_keeper/model/types/home/task/todo.dart';

class TaskBottomField extends StatelessWidget {
  final Task task;
  final RxBool isAddTodo;
  final RxBool changeTitle;
  const TaskBottomField(
      {Key? key,
      required this.task,
      required this.isAddTodo,
      required this.changeTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController todoController = TextEditingController();

    void addTodo() {
      if (todoController.text.isNotEmpty) {
        task.todos.add(Todo(title: todoController.text));
        isAddTodo.value = !isAddTodo.value;
      }
    }

    Widget addTodoWidget = Padding(
      padding: const EdgeInsets.all(8),
      child: TextButton.icon(
          style: TextButton.styleFrom(
              alignment: Alignment.centerLeft,
              fixedSize: Size.fromWidth(MediaQuery.of(context).size.width)),
          icon: const Icon(Icons.add),
          onPressed: () {
            changeTitle.value = false;
            isAddTodo.value = !isAddTodo.value;
          },
          label: const AutoSizeText('Add Todo')),
    );

    Widget addTodoField = Transform.translate(
        offset: Offset(0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(children: [
              Checkbox(value: false, onChanged: (value) {}),
              Expanded(
                child: TextField(
                  autofocus: true,
                  controller: todoController,
                  maxLines: 1,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Write todo'),
                  onSubmitted: (value) {
                    addTodo();
                  },
                ),
              ),
              IconButton(
                  onPressed: addTodo,
                  icon: const Icon(Icons.done),
                  splashRadius: 20)
            ])));

    return Obx(() => isAddTodo.value ? addTodoField : addTodoWidget);
  }
}