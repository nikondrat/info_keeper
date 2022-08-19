import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home/todo/task.dart';

class TodoBottomField extends StatelessWidget {
  final List tasks;
  const TodoBottomField({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Row(
      children: [
        Checkbox(value: false, onChanged: (value) {}),
        Expanded(
          child: TextFormField(
            autocorrect: true,
            autofocus: true,
            controller: controller,
            textInputAction: TextInputAction.newline,
            maxLines: 1,
            cursorColor: Colors.black,
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: 'Text'),
          ),
        ),
        IconButton(
            splashRadius: 20,
            onPressed: () {
              if (controller.text.isNotEmpty) {
                tasks.add(Task(title: controller.text, taskIsCompleted: false));
              }
            },
            icon: const Icon(Icons.done))
      ],
    );
  }
}
