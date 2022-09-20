import 'package:flutter/material.dart';

class ChatAppBarBottomWidget extends StatelessWidget {
  const ChatAppBarBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text('hello'),
      style: ListTileStyle.drawer,
    );
  }
}
