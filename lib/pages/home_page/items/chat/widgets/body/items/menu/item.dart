import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  final String title;
  final Icon icon;
  final Function() onPressed;
  const MenuItemWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      style: const ButtonStyle(
        alignment: Alignment.centerLeft,
      ),
      label: Text(title),
      icon: icon,
    );
  }
}
