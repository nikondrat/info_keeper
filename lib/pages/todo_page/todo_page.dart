import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/location_element.dart';
import 'package:info_keeper/model/types/task.dart';
import 'package:info_keeper/model/types/todo.dart';
import 'package:info_keeper/pages/todo_page/widgets/todo_body.dart';
import 'package:info_keeper/pages/todo_page/widgets/todo_text_field.dart';

class TodoPage extends StatelessWidget {
  final Todo? todo;
  final bool change;
  const TodoPage({Key? key, this.todo, this.change = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: todo != null ? todo!.name : '');
    final tasks = [Task(title: '')].obs;

    if (todo != null) {
      tasks.value = todo!.tasks!;
      if (!change) {
        tasks.insert(0, Task(title: ''));
      }
    }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
            splashRadius: 20,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                change
                    ? Controller.to.change(Todo(
                        name: titleController.text,
                        tasks: tasks,
                        location: LocationElement(
                            inDirectory: Controller.to.selectedFolder.value,
                            index: Controller
                                    .to
                                    .all[Controller.to.selectedFolder.value]
                                    .directoryChildrens
                                    .length -
                                1),
                      ))
                    : Controller.to.add(Todo(
                        name: titleController.text,
                        tasks: tasks,
                        location: LocationElement(
                            inDirectory: Controller.to.selectedFolder.value,
                            index: Controller
                                    .to
                                    .all[Controller.to.selectedFolder.value]
                                    .directoryChildrens
                                    .length -
                                1),
                      ));
              }
              Get.back();
            }),
        actions: [
          change
              ? Padding(
                  padding: const EdgeInsets.all(8),
                  child: IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        if (titleController.text.isNotEmpty) {
                          Controller.to.change(Todo(
                              name: titleController.text,
                              location: LocationElement(
                                  inDirectory:
                                      Controller.to.selectedFolder.value,
                                  index: Controller
                                          .to
                                          .all[Controller
                                              .to.selectedFolder.value]
                                          .directoryChildrens
                                          .length -
                                      1),
                              tasks: tasks));
                          Get.back();
                        }
                      },
                      icon: const Icon(Icons.done)),
                )
              : Padding(
                  padding: const EdgeInsets.all(8),
                  child: IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        if (titleController.text.isNotEmpty) {
                          Controller.to.add(Todo(
                              location: LocationElement(
                                  inDirectory:
                                      Controller.to.selectedFolder.value,
                                  index: Controller
                                          .to
                                          .all[Controller
                                              .to.selectedFolder.value]
                                          .directoryChildrens
                                          .length -
                                      1),
                              name: titleController.text,
                              tasks: tasks));
                          Get.back();
                        }
                      },
                      icon: const Icon(Icons.add)),
                )
        ],
        title: TodoPageTextField(
          titleController: titleController,
        ),
      ),
      body: TodoPageBody(tasks: tasks),
    );
  }
}
