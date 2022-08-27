import 'package:flutter/material.dart';

class ChatBottomFileSelectorButton extends StatelessWidget {
  const ChatBottomFileSelectorButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        splashRadius: 20,
        onPressed: () {},
        icon: const Icon(Icons.attach_file));
  }
}
