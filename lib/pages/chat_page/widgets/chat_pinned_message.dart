import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/chat/chat.dart';
import 'package:info_keeper/pages/chat_page/chat_pinned_messages.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ChatPagePinnedMessage extends StatelessWidget {
  final RxList pinnedMessages;
  final AutoScrollController autoScrollController;
  const ChatPagePinnedMessage(
      {Key? key,
      required this.pinnedMessages,
      required this.autoScrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          autoScrollController
              .scrollToIndex(pinnedMessages[0].location.selectedMessageIndex);
        },
        style: ListTileStyle.drawer,
        contentPadding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        dense: true,
        minLeadingWidth: 1,
        horizontalTitleGap: 4,
        leading: VerticalDivider(
          width: 20,
          thickness: 2,
          color: Colors.grey.shade700,
        ),
        title: Text(
          pinnedMessages[0].title.isNotEmpty
              ? pinnedMessages[0].title
              : 'Pinned Message',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(fontSize: 14),
        ),
        subtitle: Text(
          pinnedMessages[0].messageText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: pinnedMessages.length > 1
            ? IconButton(
                splashRadius: 20,
                onPressed: () => Get.to(() => ChatPagePinnedMessages(
                      messages: pinnedMessages,
                    )),
                icon: const Icon(Icons.article_outlined))
            : IconButton(
                onPressed: () {
                  final messages = Controller
                      .to
                      .all[Controller.to.selectedFolder.value]
                      .childrens[Controller.to.selectedElementIndex.value]
                      .messages;
                  messages[pinnedMessages[0].location.selectedMessageIndex]
                          .isPinned =
                      !messages[pinnedMessages[0].location.selectedMessageIndex]
                          .isPinned;

                  pinnedMessages.removeAt(0);
                  Controller.to.change(
                      Chat(messages: messages, pinnedMessages: pinnedMessages));
                },
                splashRadius: 20,
                icon: Icon(
                  Icons.close,
                  color: Colors.grey.shade700,
                )));
  }
}
