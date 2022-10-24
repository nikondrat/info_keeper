import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home_item.dart';

class BodyItemDecoration extends StatelessWidget {
  final Widget child;
  final HomeItem homeItem;
  const BodyItemDecoration({
    Key? key,
    required this.homeItem,
    required this.child,
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
              width: 1)),
      child: child,
    );
  }
}
