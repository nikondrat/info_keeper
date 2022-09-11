import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/task/task.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item_child_body.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item_decoration.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item_gesture.dart';
import 'package:info_keeper/pages/home_page/items/task/widgets/todo.dart';

class TodoItem extends StatelessWidget {
  final int homeItemIndex;
  final HomeItem homeItem;
  final String term;
  const TodoItem(
      {Key? key,
      required this.homeItemIndex,
      required this.homeItem,
      required this.term})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Task task = homeItem.child;

    return HomeBodyItemGesture(
        homeItemIndex: homeItemIndex,
        homeItem: homeItem,
        child: BodyItemDecoration(
            homeItem: homeItem,
            child: HomeBodyItemChildBody(
                homeItem: homeItem,
                term: term,
                verticalChild: Obx(() => ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: task.todos.length,
                    itemBuilder: (context, todoIndex) {
                      return TodoWidget(
                          index: todoIndex, homeItem: homeItem, change: false);
                    })))));
  }
}
