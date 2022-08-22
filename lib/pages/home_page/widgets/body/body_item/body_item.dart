import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item_anim.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item_child.dart';

class HomeBodyItem extends StatelessWidget {
  final int homeItemIndex;
  final HomeItem homeItem;
  final String term;
  final bool isVault;
  final bool isTrash;

  const HomeBodyItem(
      {Key? key,
      required this.homeItemIndex,
      required this.homeItem,
      this.term = '',
      this.isTrash = false,
      this.isVault = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return homeItem.isAnimated
        ? HomeBodyItemAnimation(
            bodyItem: HomeBodyItemChild(
                homeItemIndex: homeItemIndex, homeItem: homeItem, term: term))
        : HomeBodyItemChild(
            homeItemIndex: homeItemIndex, homeItem: homeItem, term: term);
  }
}
