import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';
import 'package:info_keeper/pages/home_page/items/storage_file/storage_file_page.dart';
import 'package:info_keeper/pages/trash_page/trash_element.dart';
import 'package:substring_highlight/substring_highlight.dart';

class HomeWidgetStorageFile extends StatelessWidget {
  final HomeItem homeItem;
  final int index;
  final String term;
  final bool? isTrash;
  const HomeWidgetStorageFile(
      {Key? key,
      required this.homeItem,
      required this.index,
      this.isTrash,
      this.term = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isShowRestoreMenu = false.obs;
    late final HomeController home = Get.find();

    return Theme(
        data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent),
        child: GestureDetector(
            onTap: isTrash != null
                ? null
                : () {
                    home.isShowBottomMenu.value = false;
                    home.isShowDialMenu.value = false;
                    Controller.to.selectedElementIndex.value = index;
                    Get.to(() =>
                        StorageFilePage(homeItem: homeItem, change: true));
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: homeItem.child.value.isAnimated
                              ? const Color(0xFFB9DFBB)
                              : Colors.grey.shade600,
                          width: homeItem.isAnimated ? 1.4 : 1)),
                  child: ExpansionWidget(
                    content: Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: Text(homeItem.child.value.data!, maxLines: 6),
                    ),
                    titleBuilder: (animationValue, easeInValue, isExpanded,
                            toggleFunction) =>
                        Padding(
                      padding: const EdgeInsets.only(
                          left: 12, top: 6, bottom: 6, right: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          homeItem.isPinned
                              ? const Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Icon(Icons.push_pin_outlined),
                                )
                              : const SizedBox(),
                          homeItem.isLink
                              ? const Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Icon(Icons.subdirectory_arrow_left),
                                )
                              : const SizedBox(),
                          homeItem.isDublicated
                              ? const Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Icon(Icons.copy_all),
                                )
                              : const SizedBox(),
                          Expanded(
                            child: SubstringHighlight(
                              term: term,
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              text: homeItem.name,
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
