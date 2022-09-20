import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/btm_app_bar/btm_app_bar_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/btm_app_bar/widgets/color_selector/color_item.dart';
import 'package:info_keeper/themes/default/default.dart';

class ChatBottomAppBarColorSelector extends StatelessWidget {
  final Chat chat;
  final Message message;
  const ChatBottomAppBarColorSelector(
      {super.key, required this.chat, required this.message});

  @override
  Widget build(BuildContext context) {
    final BottomAppBarController bottomAppBarController = Get.find();
    bottomAppBarController.selectedColor.value =
        chat.messages[Controller.to.selectedElementIndex.value].color;

    return AspectRatio(
      aspectRatio: 16 / 5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 6),
                  child: AutoSizeText(
                    'Color select',
                    style: TextStyle(color: Color(0xFF42729A), fontSize: 16),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: messageColors.length,
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 30,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        return ColorSelectorItem(
                            itemIndex: index, chat: chat, message: message);
                      }),
                ),
              ],
            ),
          ),
          RawMaterialButton(
            onPressed: () => Navigator.pop(context),
            highlightElevation: 0,
            elevation: 1,
            splashColor: Colors.transparent,
            fillColor: Colors.blue,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.done,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
