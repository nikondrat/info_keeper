import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/btm_app_bar/btm_app_bar_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/btm_app_bar/widgets/file_selector_btn.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/btm_app_bar/widgets/recorder.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/btm_app_bar/widgets/send_btn.dart';

class ChatBottomTextField extends StatelessWidget {
  final HomeItem homeItem;
  const ChatBottomTextField({Key? key, required this.homeItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomAppBarController>(
      init: BottomAppBarController(),
      builder: (controller) => Row(children: [
        IconButton(
            splashRadius: 20,
            onPressed: () {
              controller.isShowTitleTextField.value =
                  !controller.isShowTitleTextField.value;
              controller.update();
            },
            icon: const Icon(Icons.title)),
        Expanded(
            child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.14),
          child: TextField(
              controller: controller.messageController,
              // autofocus: editMessage.value ? true : false,
              maxLines: null,
              // focusNode: focusNode,
              decoration: const InputDecoration(
                  hintText: 'Write text',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  border: InputBorder.none),
              onEditingComplete: () {
                controller.messageController.text.isEmpty
                    ? controller.textFieldIsEmpty.value = true
                    : controller.textFieldIsEmpty.value = false;
                controller.update();
              },
              onChanged: (value) {
                value.isEmpty
                    ? controller.textFieldIsEmpty.value = true
                    : controller.textFieldIsEmpty.value = false;
                controller.update();
              }),
        )),
        Obx(() => !controller.isEditMessage.value &&
                controller.textFieldIsEmpty.value &&
                (Platform.isAndroid || Platform.isIOS)
            ? Row(children: [
                ChatBottomFileSelectorButton(homeItem: homeItem),
                ChatBottomRecorder(homeItem: homeItem)
              ])
            : ChatBottomSendButton(homeItem: homeItem))
      ]),
    );
  }
}
