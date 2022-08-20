import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/todo/todo.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item_child_body.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item_decoration.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item_gesture.dart';

class TodoItem extends StatelessWidget {
  final int index;
  final HomeItem homeItem;
  final String term;
  const TodoItem(
      {Key? key,
      required this.index,
      required this.homeItem,
      required this.term})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<Todo> todo = Rx(homeItem.child);

    return HomeBodyItemGesture(
        index: index,
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
                    itemCount: todo.value.tasks.length,
                    itemBuilder: (context, index) {
                      return todo.value.tasks[index].title.isNotEmpty
                          ? Text(todo.value.tasks[index].title)
                          : const SizedBox();
                    })))));
  }
}
