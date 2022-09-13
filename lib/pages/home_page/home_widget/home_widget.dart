import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/home_widget/home_widget_animation.dart';
import 'package:info_keeper/pages/home_page/home_widget/home_widget_child.dart';

class HomeWidget extends StatelessWidget {
  final HomeItem homeItem;
  final String term;
  final int index;
  final bool isVault;
  final bool isTrash;
  const HomeWidget(
      {Key? key,
      required this.homeItem,
      required this.index,
      this.term = '',
      this.isTrash = false,
      this.isVault = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return homeItem.isAnimated
        ? HomeWidgetAnimation(
            child: HomeWidgetChild(
            index: index,
            homeItem: homeItem,
            term: term,
            isVault: isVault,
            isTrash: isTrash,
          ))
        : HomeWidgetChild(
            index: index,
            homeItem: homeItem,
            term: term,
            isVault: isVault,
            isTrash: isTrash,
          );
  }
}
