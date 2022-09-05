import 'package:flutter/material.dart';

class PopupMenuItemWidget extends StatelessWidget {
  final int? index;
  final String title;
  final IconData icon;
  final Function() onTap;
  const PopupMenuItemWidget(
      {super.key,
      this.index,
      required this.onTap,
      required this.title,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return PopupMenuItem(
        value: index,
        onTap: onTap,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(icon),
            ),
            Text(title)
          ],
        ));
  }
}
