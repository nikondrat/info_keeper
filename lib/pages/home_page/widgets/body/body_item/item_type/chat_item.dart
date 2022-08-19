import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home_item.dart';

class ChatItem extends StatelessWidget {
  final HomeItem homeItem;
  const ChatItem({Key? key, required this.homeItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(homeItem.name),
    );
  }
}
