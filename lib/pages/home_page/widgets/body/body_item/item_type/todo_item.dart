import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item_decoration.dart';

class TodoItem extends StatelessWidget {
  final HomeItem homeItem;
  final String term;
  const TodoItem({Key? key, required this.homeItem, required this.term})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BodyItemDecoration(
      homeItem: homeItem,
      term: term,
    );
  }
}
