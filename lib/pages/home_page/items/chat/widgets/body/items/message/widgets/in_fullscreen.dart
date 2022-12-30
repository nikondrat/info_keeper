import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/message/widgets/body.dart';

class MessageWidgetInFullScreen extends StatelessWidget {
  final Message message;
  const MessageWidgetInFullScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
        onDismissed: () {
          Navigator.of(context).pop();
        },
        direction: DismissiblePageDismissDirection.multi,
        isFullScreen: false,
        startingOpacity: 0.6,
        child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: MessageWidgetBody(
              message: message,
              inFullscreen: true,
            )));
  }
}
