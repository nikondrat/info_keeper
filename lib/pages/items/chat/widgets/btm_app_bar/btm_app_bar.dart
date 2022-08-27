import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/pages/items/chat/widgets/btm_app_bar/widgets/text_field.dart';
import 'package:info_keeper/pages/items/chat/widgets/btm_app_bar/widgets/title_text_field.dart';

class ChatBottomAppBar extends StatelessWidget {
  const ChatBottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RxBool isShowTitleTextField = false.obs;

    return Transform.translate(
        offset: Offset(0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: BottomAppBar(
            child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  width: 1,
                  color: Colors.grey.shade300,
                ))),
                child: Obx(() => isShowTitleTextField.value
                    ? Column(mainAxisSize: MainAxisSize.min, children: [
                        const ChatBottomTitleTextField(),
                        ChatBottomTextField(
                            isShowTitleTextField: isShowTitleTextField)
                      ])
                    : ChatBottomTextField(
                        isShowTitleTextField: isShowTitleTextField)))));
  }
}
