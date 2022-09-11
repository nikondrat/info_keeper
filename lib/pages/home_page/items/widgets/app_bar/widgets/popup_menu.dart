import 'package:flutter/material.dart';

class PopupMenuItemBody extends StatelessWidget {
  final int? index;
  final String title;
  final IconData icon;
  const PopupMenuItemBody(
      {super.key, this.index, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Icon(icon),
        ),
        Text(title)
      ],
    );
  }
}
