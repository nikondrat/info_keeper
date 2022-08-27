import 'package:flutter/material.dart';

class ChatBottomTitleTextField extends StatelessWidget {
  const ChatBottomTitleTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.send,
      decoration: const InputDecoration(
          hintText: 'Write title',
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          border: InputBorder.none),
    );
  }
}
