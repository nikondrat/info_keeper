import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  final String title;
  final Icon icon;
  final Function() onPressed;
  final bool done;
  const MenuItemWidget(
      {super.key,
      required this.title,
      required this.icon,
      this.done = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return kDebugMode && done
        ? const Text('done')
        : TextButton.icon(
            onPressed: onPressed,
            style: const ButtonStyle(
              alignment: Alignment.centerLeft,
            ),
            label: Text(title),
            icon: icon,
          );
  }
}
