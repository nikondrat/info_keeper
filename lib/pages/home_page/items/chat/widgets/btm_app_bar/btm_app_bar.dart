import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/btm_app_bar/btm_app_bar_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/btm_app_bar/widgets/edit_message.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/btm_app_bar/widgets/text_field.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/btm_app_bar/widgets/title_text_field.dart';

class ChatBottomAppBar extends StatelessWidget {
  final HomeItem homeItem;
  const ChatBottomAppBar({Key? key, required this.homeItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BottomAppBarController barController =
        Get.put(BottomAppBarController());

    return Transform.translate(
        offset: Offset(0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: BottomAppBar(
            child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  color: Colors.grey,
                ))),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Obx(() => barController.isEditMessage.value
                      ? const BottomAppBarEditMessageWidget()
                      : const SizedBox()),
                  Obx(() => barController.isShowTitleTextField.value
                      ? const ChatBottomTitleTextField()
                      : const SizedBox()),
                  ChatBottomTextField(homeItem: homeItem)
                ]))));
  }
}
