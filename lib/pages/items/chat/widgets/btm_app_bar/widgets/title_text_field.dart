import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/pages/items/chat/widgets/btm_app_bar/btm_app_bar_controller.dart';

class ChatBottomTitleTextField extends StatelessWidget {
  const ChatBottomTitleTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomAppBarController>(
      init: BottomAppBarController(),
      builder: (controller) => TextField(
        controller: controller.titleController,
        cursorColor: Colors.black,
        textInputAction: TextInputAction.send,
        decoration: const InputDecoration(
            hintText: 'Write title',
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            border: InputBorder.none),
      ),
    );
  }
}
