import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/storage_file.dart';
import 'package:info_keeper/pages/storage_file_page/storage_file_page.dart';
import 'package:substring_highlight/substring_highlight.dart';

class HomeWidgetStorageFile extends StatelessWidget {
  final StorageFile storageFile;
  final int index;
  final String term;
  const HomeWidgetStorageFile(
      {Key? key,
      required this.storageFile,
      required this.index,
      this.term = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent),
        child: GestureDetector(
          onTap: () {
            Controller.to.isShowDial.value = false;
            Controller.to.isShowMenu.value = false;
            Controller.to.selectedElementIndex.value = index;
            Get.to(() => StorageFilePage(file: storageFile, change: true));
          },
          onLongPress: () {
            Controller.to.isShowMenu.value = true;
            Controller.to.selectedElementIndex.value = index;
          },
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                      color: storageFile.animate
                          ? const Color(0xFFB9DFBB)
                          : Colors.grey.shade600,
                      width: storageFile.animate ? 1.4 : 1)),
              child: ExpansionWidget(
                content: Text(storageFile.data!, maxLines: 6),
                titleBuilder:
                    (animationValue, easeInValue, isExpanded, toggleFunction) =>
                        Padding(
                  padding: const EdgeInsets.only(
                      left: 12, top: 6, bottom: 6, right: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      storageFile.link
                          ? const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(Icons.subdirectory_arrow_left),
                            )
                          : Container(),
                      storageFile.dublicated
                          ? const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(Icons.copy_all),
                            )
                          : Container(),
                      Expanded(
                        child: SubstringHighlight(
                          term: term,
                          text: storageFile.name!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                          onPressed: () => toggleFunction(animated: true),
                          icon: Icon(isExpanded
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down))
                    ],
                  ),
                ),
              )),
        ));
  }
}
