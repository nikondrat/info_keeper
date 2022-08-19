import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item_child_body.dart';

class BodyItemDecoration extends StatelessWidget {
  final HomeItem homeItem;
  final String term;
  const BodyItemDecoration({
    Key? key,
    required this.homeItem,
    required this.term,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: homeItem.isAnimated
                  ? const Color(0xFFB9DFBB)
                  : Colors.grey.shade600,
              width: homeItem.isAnimated ? 1.4 : 1)),
      child: HomeBodyItemChildBody(homeItem: homeItem, term: term),
    );
  }
}
