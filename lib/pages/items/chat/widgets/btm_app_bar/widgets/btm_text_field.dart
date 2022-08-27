import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatBottomTextField extends StatelessWidget {
  final RxBool isShowTitleTextField;
  const ChatBottomTextField({Key? key, required this.isShowTitleTextField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();

    return Row(children: [
      IconButton(
          splashRadius: 20,
          onPressed: () =>
              isShowTitleTextField.value = !isShowTitleTextField.value,
          icon: const Icon(Icons.title)),
      Expanded(
          child: TextField(
              controller: messageController,
              // autofocus: editMessage.value ? true : false,
              maxLines: null,
              // focusNode: focusNode,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                  hintText: 'Write text',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  border: InputBorder.none),
              onEditingComplete: () {
                // contentController.text.isEmpty
                //     ? textFieldIsEmpty.value = true
                //     : textFieldIsEmpty.value = false;
              },
              onChanged: (value) {
                // value.isEmpty
                //     ? textFieldIsEmpty.value = true
                //     : textFieldIsEmpty.value = false;
              })),
      IconButton(
          splashRadius: 20,
          onPressed: () {},
          icon: const Icon(Icons.attach_file))
    ]);
  }
}
