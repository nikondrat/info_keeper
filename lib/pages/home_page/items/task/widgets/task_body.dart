import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/items/task/widgets/todo.dart';
import 'package:info_keeper/themes/widgets/body.dart';

class TaskPageBody extends StatelessWidget {
  final HomeItem homeItem;
  const TaskPageBody({Key? key, required this.homeItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BodyWithTheme(
        body: Obx(
      () => ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: homeItem.child.todos.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return TodoWidget(homeItem: homeItem, index: index);
          }),
    ));
  }
}
