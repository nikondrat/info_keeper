import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/task/task.dart';
import 'package:info_keeper/model/types/home/task/todo.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/item_location.dart';
import 'package:info_keeper/pages/task_page/widgets/btm_field.dart';
import 'package:info_keeper/pages/task_page/widgets/title.dart';
import 'package:info_keeper/pages/task_page/widgets/task_body.dart';

class TaskPage extends StatelessWidget {
  final HomeItem? homeItem;
  final bool change;
  const TaskPage({Key? key, this.homeItem, this.change = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String defaultName = 'Список без названия';
    final TextEditingController titleController =
        TextEditingController(text: homeItem?.name ?? defaultName);
    Task task = homeItem?.child ?? Task(todos: <Todo>[].obs);
    RxBool changeTitle = false.obs;
    RxBool isAddTodo = false.obs;
    FocusNode titleFocus = FocusNode();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: Obx(() => IconButton(
            splashRadius: 20,
            icon: Icon(changeTitle.value ? Icons.close : Icons.arrow_back),
            onPressed: changeTitle.value
                ? () {
                    changeTitle.value = !changeTitle.value;
                    titleFocus.unfocus();
                    change
                        ? titleController.text = homeItem!.name
                        : titleController.text = defaultName;
                  }
                : () =>
                    // : () {
                    //     change
                    //         ? homeItem?.copyWith(name: titleController.text)
                    //         : Controller.to.add(HomeItem(
                    //             name: titleController.text,
                    //             child: Task(todos: task.todos),
                    //             location: ItemLocation(
                    //                 inDirectory: Controller.to.selectedFolder.value,
                    //                 index: Controller
                    //                     .to
                    //                     .all[Controller.to.selectedFolder.value]
                    //                     .childrens
                    //                     .length)));

                    Get.back())),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8),
              child: Obx(() => IconButton(
                  splashRadius: 20,
                  onPressed: changeTitle.value
                      ? () {
                          if (titleController.text.isNotEmpty) {
                            changeTitle.value = !changeTitle.value;
                            titleFocus.unfocus();
                            defaultName = titleController.text;
                          }
                        }
                      : () {
                          change
                              ? homeItem?.copyWith(name: titleController.text)
                              : Controller.to.add(HomeItem(
                                  name: titleController.text,
                                  child: Task(todos: task.todos),
                                  location: ItemLocation(
                                      inDirectory:
                                          Controller.to.selectedFolder.value,
                                      index: Controller
                                          .to
                                          .all[Controller
                                              .to.selectedFolder.value]
                                          .childrens
                                          .length)));
                          Get.back();
                        },
                  icon: Icon(
                      change || changeTitle.value ? Icons.done : Icons.add))))
        ],
        title: TaskTitle(
            titleFocus: titleFocus,
            titleController: titleController,
            changeTitle: changeTitle,
            addTodo: isAddTodo),
      ),
      body: TaskPageBody(task: task),
      bottomNavigationBar: TaskBottomField(
          task: task, isAddTodo: isAddTodo, changeTitle: changeTitle),
    );
  }
}
