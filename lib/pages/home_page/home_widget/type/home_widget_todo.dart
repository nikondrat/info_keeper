import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/todo.dart';
import 'package:info_keeper/pages/todo_page/todo_page.dart';
import 'package:info_keeper/pages/todo_page/widgets/todo_task.dart';
import 'package:info_keeper/pages/trash_page/trash_element.dart';
import 'package:substring_highlight/substring_highlight.dart';

class HomeWidgetTodo extends StatelessWidget {
  final Todo todo;
  final String term;
  final int index;
  final bool? isTrash;
  const HomeWidgetTodo(
      {Key? key,
      required this.index,
      required this.todo,
      this.term = '',
      this.isTrash})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isShowRestoreMenu = false.obs;

    return GestureDetector(
      onTap: isTrash != null
          ? null
          : () {
              Controller.to.isShowDial.value = false;
              Controller.to.isShowMenu.value = false;
              Controller.to.selectedElementIndex.value = index;
              Get.to(() => TodoPage(todo: todo, change: true));
            },
      onLongPress: isTrash != null
          ? () => isShowRestoreMenu.value = true
          : () {
              Controller.to.isShowMenu.value = true;
              Controller.to.selectedElementIndex.value = index;
            },
      child: TrashElement(
          isShowRestoreMenu: isShowRestoreMenu,
          index: index,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    color: todo.animate
                        ? const Color(0xFFB9DFBB)
                        : Colors.grey.shade600,
                    width: todo.animate ? 1.4 : 1)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      todo.pinned
                          ? const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(Icons.push_pin_outlined),
                            )
                          : Container(),
                      todo.dublicated
                          ? const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(Icons.copy_all),
                            )
                          : Container(),
                      Expanded(
                        child: SubstringHighlight(
                          term: term,
                          text: todo.name!,
                          textStyle: const TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Obx(() => ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          todo.tasks!.length < 11 ? todo.tasks!.length : 11,
                      itemBuilder: (context, index) {
                        return todo.tasks![index].title.isNotEmpty
                            ? TodoPageTaskWidget(
                                tasks: todo.tasks!,
                                index: index,
                                change: false,
                              )
                            : Container();
                      }))
                ]),
          )),
    );
  }
}
