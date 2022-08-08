import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/pages/chat_page/chat_page.dart';
import 'package:substring_highlight/substring_highlight.dart';

class HomeWidgetChat extends StatelessWidget {
  final String term;
  final int index;
  const HomeWidgetChat({Key? key, required this.index, this.term = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Controller.to.isShowDial.value = false;
        Controller.to.isShowMenu.value = false;
        Controller.to.selectedElementIndex.value = index;
        Get.to(() => ChatPage(
              chatIndex: index,
            ));
      },
      onLongPress: () {
        Controller.to.isShowMenu.value = true;
        Controller.to.selectedElementIndex.value = index;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color: Controller.to.all[Controller.to.selectedFolder.value]
                        .directoryChildrens[index].animate
                    ? const Color(0xFFB9DFBB)
                    : Colors.grey.shade600,
                width: Controller.to.all[Controller.to.selectedFolder.value]
                        .directoryChildrens[index].animate
                    ? 1.4
                    : 1)),
        child: Row(
          children: [
            Controller.to.all[Controller.to.selectedFolder.value]
                    .directoryChildrens[index].pinned
                ? const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.push_pin_outlined),
                  )
                : Container(),
            Controller.to.all[Controller.to.selectedFolder.value]
                    .directoryChildrens[index].link
                ? const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.subdirectory_arrow_left),
                  )
                : Container(),
            Controller.to.all[Controller.to.selectedFolder.value]
                    .directoryChildrens[index].dublicated
                ? const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.copy_all),
                  )
                : Container(),
            Expanded(
              child: SubstringHighlight(
                term: term,
                text: Controller.to.all[Controller.to.selectedFolder.value]
                    .directoryChildrens[index].name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
