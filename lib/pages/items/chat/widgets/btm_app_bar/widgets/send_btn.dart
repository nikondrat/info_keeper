import 'package:flutter/material.dart';

class ChatBottomSendButton extends StatelessWidget {
  const ChatBottomSendButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        splashRadius: 20, onPressed: () {}, icon: const Icon(Icons.send));
  }
}
