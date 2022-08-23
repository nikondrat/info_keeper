import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item_child_body.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item_decoration.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item_gesture.dart';

class ChatItem extends StatelessWidget {
  final int homeItemIndex;
  final HomeItem homeItem;
  final String term;
  const ChatItem(
      {Key? key,
      required this.homeItemIndex,
      required this.homeItem,
      required this.term})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeBodyItemGesture(
        homeItemIndex: homeItemIndex,
        homeItem: homeItem,
        child: BodyItemDecoration(
            homeItem: homeItem,
            child: HomeBodyItemChildBody(
              homeItem: homeItem,
              term: term,
            )));
  }
}
