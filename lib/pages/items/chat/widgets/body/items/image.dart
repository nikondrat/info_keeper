import 'dart:io';

import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home/chat/items/image.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/items/item_decoration.dart';

class ChatImageWidget extends StatelessWidget {
  final ChatImage image;
  final double elevation;
  const ChatImageWidget({super.key, required this.image, this.elevation = 0});

  @override
  Widget build(BuildContext context) {
    return ItemDecoration(
        elevation: elevation,
        padding: EdgeInsets.zero,
        dateTime: image.dateTime,
        child: GestureDetector(
          onTap: () =>
              context.pushTransparentRoute(ChatImageInFullscreen(image: image)),
          child: Hero(
              tag: image.path,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.file(
                  File(image.path),
                  isAntiAlias: true,
                  height: MediaQuery.of(context).size.height * 0.4,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              )),
        ));
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
      child: Hero(
        tag: image.path,
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
