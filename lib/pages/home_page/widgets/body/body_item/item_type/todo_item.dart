import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:info_keeper/model/types/home_item.dart';

class TodoItem extends StatelessWidget {
  final HomeItem homeItem;
  const TodoItem({Key? key, required this.homeItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(homeItem.name),
    );
  }
}
