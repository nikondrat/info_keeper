import 'package:flutter/material.dart';
import 'package:info_keeper/pages/home_page/home_widget/home_widget_animation.dart';
import 'package:info_keeper/pages/home_page/home_widget/home_widget_child.dart';

class HomeWidget extends StatelessWidget {
  final dynamic value;
  final String term;
  final int index;
  final bool? isVault;
  final bool? isTrash;
  const HomeWidget(
      {Key? key,
      required this.value,
      required this.index,
      this.term = '',
      this.isTrash,
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
            isTrash: isTrash,
          ))
        : HomeWidgetChild(
            index: index,
            value: value,
            term: term,
            isVault: isVault,
            isTrash: isTrash,
          );
  }
}
