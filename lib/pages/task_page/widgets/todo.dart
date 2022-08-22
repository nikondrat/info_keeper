import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/task/task.dart';
import 'package:info_keeper/model/types/home/task/todo.dart';

class TodoWidget extends StatelessWidget {
  final int index;
  final bool change;
  final Task task;
  const TodoWidget(
      {Key? key, required this.index, this.change = true, required this.task})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller =
        TextEditingController(text: task.todos[index].title);

    Widget todoWidget = Row(
      children: [
        Checkbox(
            activeColor: Colors.grey.shade600,
            fillColor: MaterialStateProperty.all(Colors.grey.shade600),
            value: task.todos[index].isCompleted,
            onChanged: (value) {
              task.todos[index].copyWith(index: index, isCompleted: value);
              Controller.to.setData();
            }),
        Expanded(
          child: change
              ? TextField(
                  autocorrect: true,
                  controller: controller,
                  maxLines: 1,
                  cursorColor: Colors.black,
                  onSubmitted: (value) {
                    if (controller.text.isNotEmpty) {
                      if (change && index != 0) {
                        task.todos[index] = Todo(
                            title: controller.text,
                            isCompleted: task.todos[index].isCompleted);
                      } else {
                        task.todos.insert(1, Todo(title: controller.text));
                      }
                    }
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Text'),
                )
              : AutoSizeText(
                  task.todos[index].title,
                  style: const TextStyle(fontSize: 16),
                ),
        )
      ],
    );

    return todoWidget;
  }
}
