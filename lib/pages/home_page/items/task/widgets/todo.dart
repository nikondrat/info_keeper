import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/task/task.dart';
import 'package:info_keeper/model/types/home/task/todo.dart';
import 'package:info_keeper/model/types/home_item.dart';

class TodoWidget extends StatelessWidget {
  final int index;
  final bool change;
  final HomeItem homeItem;
  const TodoWidget(
      {Key? key,
      required this.index,
      this.change = true,
      required this.homeItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Task task = homeItem.child;
    TextEditingController controller =
        TextEditingController(text: task.todos[index].title);

    Widget todoWidget = Row(
      children: [
        Checkbox(
            activeColor: Colors.grey.shade600,
            fillColor: MaterialStateProperty.all(Colors.grey.shade600),
            value: task.todos[index].isCompleted,
            onChanged: (value) {
              task.todos[index].copyWith(
                  location: homeItem.location,
                  index: index,
                  isCompleted: value);
              Controller.to.setData();
            }),
        Expanded(
          child: change
              ? RawKeyboardListener(
                  onKey: (value) {
                    if (value.logicalKey == LogicalKeyboardKey.backspace &&
                        value.runtimeType.toString() == 'RawKeyDownEvent') {
                      task.todos.removeAt(index);
                    }
                  },
                  focusNode: FocusNode(),
                  child: TextField(
                    autocorrect: true,
                    controller: controller,
                    maxLines: 1,
                    onSubmitted: (value) {
                      if (controller.text.isNotEmpty) {
                        task.todos[index] = Todo(
                            title: controller.text,
                            isCompleted: task.todos[index].isCompleted);
                      } else {
                        task.todos.removeAt(index);
                      }
                    },
                    decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintText: 'Text'),
                  ),
                )
              : AutoSizeText(
                  task.todos[index].title,
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.headline6!.color),
                ),
        )
      ],
    );

    return todoWidget;
  }
}
