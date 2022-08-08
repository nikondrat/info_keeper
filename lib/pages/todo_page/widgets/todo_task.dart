import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/task.dart';

class TodoPageTaskWidget extends StatelessWidget {
  final List<Task> tasks;
  final int index;
  final bool change;
  const TodoPageTaskWidget(
      {Key? key, required this.tasks, required this.index, this.change = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(
        text: tasks[index].title.isNotEmpty ? tasks[index].title : '');

    return Row(
      children: [
        Obx(() => Checkbox(
            fillColor: MaterialStateProperty.all(Colors.grey.shade600),
            value: tasks[index].taskIsCompleted,
            onChanged: (value) {
              if (index != 0) {
                tasks[index] =
                    Task(title: tasks[index].title, taskIsCompleted: value!);
                Controller.to.setData();
              }
            })),
        change
            ? Expanded(
                child: TextField(
                  autocorrect: true,
                  controller: controller,
                  maxLines: 1,
                  cursorColor: Colors.black,
                  onSubmitted: (value) {
                    if (controller.text.isNotEmpty) {
                      if (change && index != 0) {
                        tasks[index] = Task(
                            title: controller.text,
                            taskIsCompleted: tasks[index].taskIsCompleted);
                      } else {
                        tasks.insert(1, Task(title: controller.text));
                      }
                    }
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Text'),
                ),
              )
            : Expanded(child: Text(tasks[index].title)),
      ],
    );
  }
}
