import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/pages/chat_page/chat_page.dart';
import 'package:info_keeper/pages/trash_page/trash_element.dart';
import 'package:substring_highlight/substring_highlight.dart';

class HomeWidgetChat extends StatelessWidget {
  final String term;
  final int index;
  final bool? isTrash;
  const HomeWidgetChat(
      {Key? key, required this.index, this.term = '', this.isTrash})
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
              Get.to(() => ChatPage(
                    chatIndex: index,
                  ));
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    color: isTrash != null
                        ? Controller.to.trashElements[index].animate
                            ? const Color(0xFFB9DFBB)
                            : Colors.grey.shade600
                        : Controller.to.all[Controller.to.selectedFolder.value]
                                .directoryChildrens[index].animate
                            ? const Color(0xFFB9DFBB)
                            : Colors.grey.shade600,
                    width: isTrash != null
                        ? Controller.to.trashElements[index].animate
                            ? 1.4
                            : 1
                        : Controller.to.all[Controller.to.selectedFolder.value]
                                .directoryChildrens[index].animate
                            ? 1.4
                            : 1)),
            child: Row(
              children: [
                isTrash != null
                    ? Controller.to.trashElements[index].pinned
                        ? const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(Icons.push_pin_outlined),
                          )
                        : Container()
                    : Controller.to.all[Controller.to.selectedFolder.value]
                            .directoryChildrens[index].pinned
                        ? const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(Icons.push_pin_outlined),
                          )
                        : Container(),
                isTrash != null
                    ? Controller.to.trashElements[index].link
                        ? const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(Icons.subdirectory_arrow_left),
                          )
                        : Container()
                    : Controller.to.all[Controller.to.selectedFolder.value]
                            .directoryChildrens[index].link
                        ? const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(Icons.subdirectory_arrow_left),
                          )
                        : Container(),
                isTrash != null
                    ? Controller.to.trashElements[index].dublicated
                        ? const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(Icons.copy_all),
                          )
                        : Container()
                    : Controller.to.all[Controller.to.selectedFolder.value]
                            .directoryChildrens[index].dublicated
                        ? const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(Icons.copy_all),
                          )
                        : Container(),
                Expanded(
                  child: SubstringHighlight(
                    term: term,
                    text: isTrash != null
                        ? Controller.to.trashElements[index].name
                        : Controller.to.all[Controller.to.selectedFolder.value]
                            .directoryChildrens[index].name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
