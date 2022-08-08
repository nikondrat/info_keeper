import 'package:flutter/material.dart';
import 'package:info_keeper/pages/home_page/home_widget/home_widget_animation.dart';
import 'package:info_keeper/pages/home_page/home_widget/home_widget_child.dart';

class HomeWidget extends StatelessWidget {
  final dynamic value;
  final String term;
  final int index;
  final bool? isVault;
  const HomeWidget(
      {Key? key,
      required this.value,
      required this.index,
      this.term = '',
      this.isVault})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return value.animate
        ? HomeWidgetAnimation(
            child: HomeWidgetChild(
            index: index,
            value: value,
            term: term,
            isVault: isVault,
          ))
        : HomeWidgetChild(
            index: index,
            value: value,
            term: term,
            isVault: isVault,
          );
  }
}
