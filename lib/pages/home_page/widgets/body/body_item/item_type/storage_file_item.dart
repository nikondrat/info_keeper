import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item_child_body.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item_decoration.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item_gesture.dart';

class StorageFileItem extends StatelessWidget {
  final int index;
  final HomeItem homeItem;
  final String term;
  const StorageFileItem(
      {Key? key,
      required this.index,
      required this.homeItem,
      required this.term})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent),
      child: HomeBodyItemGesture(
        homeItemIndex: index,
        homeItem: homeItem,
        child: BodyItemDecoration(
          homeItem: homeItem,
          child: ExpansionWidget(
            content: Text(
              homeItem.child.value.data,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
            ),
            titleBuilder:
                (animationValue, easeInValue, isExpanded, toggleFunction) =>
                    HomeBodyItemChildBody(
              homeItem: homeItem,
              term: term,
              horizontalChild: homeItem.child.value.data.isNotEmpty
                  ? IconButton(
                      onPressed: () => toggleFunction(animated: true),
                      icon: Icon(isExpanded
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down))
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
