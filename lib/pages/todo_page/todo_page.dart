import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/item_location.dart';
import 'package:info_keeper/model/types/home/todo/task.dart';
import 'package:info_keeper/model/types/home/todo/todo.dart';
import 'package:info_keeper/pages/todo_page/widgets/todo_body.dart';
import 'package:info_keeper/pages/todo_page/widgets/todo_text_field.dart';

class TodoPage extends StatelessWidget {
  final HomeItem? homeItem;
  final bool change;
  const TodoPage({Key? key, this.homeItem, this.change = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: homeItem != null ? homeItem!.name : '');
    final tasks = [Task(title: '')].obs;

    if (homeItem != null) {
      tasks.value = homeItem!.child.tasks!;
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
                    ? Controller.to.change(HomeItem(
                        child: Todo(tasks: tasks),
                        location: ItemLocation(
                            inDirectory: Controller.to.selectedFolder.value,
                            index: Controller
                                    .to
                                    .all[Controller.to.selectedFolder.value]
                                    .childrens
                                    .length -
                                1)))
                    : Controller.to.add(HomeItem(
                        child: Todo(tasks: tasks),
                        location: ItemLocation(
                            inDirectory: Controller.to.selectedFolder.value,
                            index: Controller
                                    .to
                                    .all[Controller.to.selectedFolder.value]
                                    .childrens
                                    .length -
                                1)));
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
                          Controller.to.change(HomeItem(
                              name: titleController.text,
                              child: Todo(tasks: tasks),
                              location: ItemLocation(
                                  inDirectory:
                                      Controller.to.selectedFolder.value,
                                  index: Controller
                                          .to
                                          .all[Controller
                                              .to.selectedFolder.value]
                                          .childrens
                                          .length -
                                      1)));
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
                          Controller.to.add(HomeItem(
                              name: titleController.text,
                              child: Todo(tasks: tasks),
                              location: ItemLocation(
                                  inDirectory:
                                      Controller.to.selectedFolder.value,
                                  index: Controller
                                          .to
                                          .all[Controller
                                              .to.selectedFolder.value]
                                          .childrens
                                          .length -
                                      1)));

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
