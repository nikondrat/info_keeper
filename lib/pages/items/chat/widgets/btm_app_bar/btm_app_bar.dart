import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/items/chat/widgets/btm_app_bar/btm_app_bar_controller.dart';
import 'package:info_keeper/pages/items/chat/widgets/btm_app_bar/widgets/text_field.dart';
import 'package:info_keeper/pages/items/chat/widgets/btm_app_bar/widgets/title_text_field.dart';

class ChatBottomAppBar extends StatelessWidget {
  final HomeItem homeItem;
  const ChatBottomAppBar({Key? key, required this.homeItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: GetBuilder<BottomAppBarController>(
                    init: BottomAppBarController(),
                    builder: (controller) =>
                        controller.isShowTitleTextField.value
                            ? Column(mainAxisSize: MainAxisSize.min, children: [
                                const ChatBottomTitleTextField(),
                                ChatBottomTextField(homeItem: homeItem)
                              ])
                            : ChatBottomTextField(homeItem: homeItem)))));
  }
}
