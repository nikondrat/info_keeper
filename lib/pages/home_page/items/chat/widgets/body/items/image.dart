import 'dart:io';

import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/items/image.dart';
import 'package:info_keeper/model/types/trash/trash_item.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/widgets/item_decoration.dart';

class ChatImageWidget extends StatelessWidget {
  final ChatImage image;
  final double elevation;
  const ChatImageWidget({super.key, required this.image, this.elevation = 0});

  @override
  Widget build(BuildContext context) {
    return ItemDecoration(
      index: image.location.itemIndex!,
      elevation: elevation,
      padding: EdgeInsets.zero,
      dateTime: image.dateTime,
      child: GestureDetector(
          onTap: () {
            context.pushTransparentRoute(ChatImageInFullscreen(image: image));
          },
          child: Stack(
            children: [
              Hero(
                tag: image.dateTime,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.file(
                      File(image.path),
                      isAntiAlias: true,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.4,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    )),
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        final ChatController chatController = Get.find();

                        final Chat chat = chatController.homeItem.child;
                        RxList messages = chat.messages;
                        Controller.to.trashElements
                            .add(TrashItem(child: image, isMessage: true));
                        messages.removeAt(messages.indexOf(image));
                      },
                      icon: const Icon(Icons.delete_outline)))
            ],
          )),
    );
  }
}

class ChatImageInFullscreen extends StatelessWidget {
  final ChatImage image;
  const ChatImageInFullscreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () {
        Navigator.of(context).pop();
      },
      direction: DismissiblePageDismissDirection.multi,
      isFullScreen: false,
      startingOpacity: 0.8,
      child: Hero(
        tag: image.dateTime,
        child: Image.file(
          File(image.path),
          fit: BoxFit.fitWidth,
          filterQuality: FilterQuality.high,
          isAntiAlias: true,
        ),
      ),
    );
  }
}
