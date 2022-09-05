import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/task/task.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/items/task/widgets/btm_field.dart';
import 'package:info_keeper/pages/items/task/widgets/task_body.dart';
import 'package:info_keeper/widgets/app_bar/app_bar.dart';
import 'package:info_keeper/widgets/app_bar/widgets/title.dart';

class TaskPage extends StatelessWidget {
  final HomeItem homeItem;
  final bool change;
  const TaskPage({Key? key, required this.homeItem, this.change = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: homeItem.name);
    Task task = homeItem.child;
    RxBool changeTitle = false.obs;
    RxBool isAddTodo = false.obs;
    FocusNode titleFocus = FocusNode();

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: AppBarWidget(
              controller: titleController,
              change: changeTitle,
              focus: titleFocus,
              actions: [
                IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      homeItem.copyWith(name: titleController.text);
                      Get.back();
                    },
                    icon: Icon(change ? Icons.done : Icons.add))
              ],
            )),
        body: TaskPageBody(homeItem: homeItem),
        bottomNavigationBar: TaskBottomField(
            task: task, isAddTodo: isAddTodo, changeTitle: changeTitle));
  }
}
