import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/storage_file.dart';
import 'package:info_keeper/pages/storage_file_page/storage_file_page.dart';
import 'package:info_keeper/pages/trash_page/trash_element.dart';
import 'package:substring_highlight/substring_highlight.dart';

class HomeWidgetStorageFile extends StatelessWidget {
  final StorageFile storageFile;
  final int index;
  final String term;
  final bool? isTrash;
  const HomeWidgetStorageFile(
      {Key? key,
      required this.storageFile,
      required this.index,
      this.isTrash,
      this.term = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isShowRestoreMenu = false.obs;

    return Theme(
        data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent),
        child: GestureDetector(
            onTap: isTrash != null
                ? null
                : () {
                    Controller.to.isShowDial.value = false;
                    Controller.to.isShowMenu.value = false;
                    Controller.to.selectedElementIndex.value = index;
                    Get.to(
                        () => StorageFilePage(file: storageFile, change: true));
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: storageFile.animate
                              ? const Color(0xFFB9DFBB)
                              : Colors.grey.shade600,
                          width: storageFile.animate ? 1.4 : 1)),
                  child: ExpansionWidget(
                    content: Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: Text(storageFile.data!, maxLines: 6),
                    ),
                    titleBuilder: (animationValue, easeInValue, isExpanded,
                            toggleFunction) =>
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
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
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
            )));
  }
}
