import 'package:flutter/material.dart';

class ChatPageMenuItem extends StatelessWidget {
  final Icon icon;
  final String text;
  final Function() function;
  const ChatPageMenuItem(
      {Key? key,
      required this.icon,
      required this.text,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: const ButtonStyle(
        alignment: Alignment.centerLeft,
      ),
      onPressed: function,
      icon: icon,
      label: Text(
        text,
      ),
    );
  }
}
