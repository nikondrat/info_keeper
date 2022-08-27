import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/pages/items/chat/widgets/btm_app_bar/widgets/file_selector_btn.dart';
import 'package:info_keeper/pages/items/chat/widgets/btm_app_bar/widgets/recorder.dart';
import 'package:info_keeper/pages/items/chat/widgets/btm_app_bar/widgets/send_btn.dart';

class ChatBottomTextField extends StatelessWidget {
  final RxBool isShowTitleTextField;
  const ChatBottomTextField({Key? key, required this.isShowTitleTextField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    final RxBool textFieldIsEmpty = true.obs;

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
                messageController.text.isEmpty
                    ? textFieldIsEmpty.value = true
                    : textFieldIsEmpty.value = false;
              },
              onChanged: (value) {
                value.isEmpty
                    ? textFieldIsEmpty.value = true
                    : textFieldIsEmpty.value = false;
              })),
      Obx(() => textFieldIsEmpty.value && (Platform.isAndroid || Platform.isIOS)
          ? Row(children: const [
              ChatBottomFileSelectorButton(),
              ChatBottomRecorder()
            ])
          : const ChatBottomSendButton())
    ]);
  }
}
