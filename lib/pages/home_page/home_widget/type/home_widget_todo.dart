import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';
import 'package:info_keeper/pages/items/task/task_page.dart';
import 'package:info_keeper/pages/items/task/widgets/todo.dart';
import 'package:info_keeper/pages/trash_page/trash_element.dart';
import 'package:substring_highlight/substring_highlight.dart';

class HomeWidgetTodo extends StatelessWidget {
  final HomeItem homeItem;
  final String term;
  final int index;
  final bool? isTrash;
  const HomeWidgetTodo(
      {Key? key,
      required this.index,
      required this.homeItem,
      this.term = '',
      this.isTrash})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isShowRestoreMenu = false.obs;
    late final HomeController home = Get.find();

    return GestureDetector(
      onTap: isTrash != null
          ? null
          : () {
              Controller.to.selectedElementIndex.value = index;
              Get.to(() => TaskPage(homeItem: homeItem, change: true));
            },
      onLongPress: isTrash != null
          ? () => isShowRestoreMenu.value = true
          : () {
              home.isShowBottomMenu.value = true;
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
                    color: homeItem.isAnimated
                        ? const Color(0xFFB9DFBB)
                        : Colors.grey.shade600,
                    width: homeItem.isAnimated ? 1.4 : 1)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      homeItem.isPinned
                          ? const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(Icons.push_pin_outlined),
                            )
                          : Container(),
                      homeItem.isDublicated
                          ? const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(Icons.copy_all),
                            )
                          : Container(),
                      Expanded(
                        child: SubstringHighlight(
                          term: term,
                          text: homeItem.name,
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
                      itemCount: homeItem.child.value.tasks!.length < 11
                          ? homeItem.child.value.tasks!.length
                          : 11,
                      itemBuilder: (context, index) {
                        return homeItem
                                .child.value.tasks![index].title.isNotEmpty
                            ? TodoWidget(
                                homeItem: homeItem,
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
