import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/pages/pinned/pinned_page.dart';

class ChatAppBarBottomWidget extends StatelessWidget {
  final RxList messages;
  const ChatAppBarBottomWidget({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    RxInt index = RxInt(0);
    final ChatController controller = Get.find();
    RxList<Message> pinnedMessages = controller.pinnedMessages(messages);
    Rx<Message> pinnedMessage = pinnedMessages[index.value].obs;

    return Obx(() => ListTile(
        onTap: () {
          if (index < pinnedMessages.length - 1) {
            index.value += 1;
          } else {
            index.value = 0;
          }
          pinnedMessage = pinnedMessages[index.value].obs;

          controller.autoScrollController
              .scrollToIndex(pinnedMessage.value.location.itemIndex!);
        },
        dense: true,
        minLeadingWidth: 1,
        horizontalTitleGap: 4,
        style: ListTileStyle.drawer,
        contentPadding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        leading: VerticalDivider(
          width: 20,
          thickness: 2,
          color: Colors.grey.shade700,
        ),
        title: AutoSizeText(
          pinnedMessages[index.value].title.isNotEmpty
              ? pinnedMessages[index.value].title
              : 'Pinned Message',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(fontSize: 14),
        ),
        subtitle: AutoSizeText(
          pinnedMessages[index.value].content,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: IconButton(
            splashRadius: 20,
            onPressed: pinnedMessages.length > 1
                ? () {
                    controller.isPinnedMessagesPage.value = true;
                    Get.to(() => const ChatPinnedMessages());
                  }
                : () {
                    pinnedMessage.value.isPinned =
                        !pinnedMessage.value.isPinned;
                    messages[pinnedMessage.value.location.itemIndex!] =
                        pinnedMessage.value;
                    controller.homeItem.child.copyWith(messages: messages);
                  },
            icon: Icon(
                pinnedMessages.length > 1
                    ? Icons.article_outlined
                    : Icons.close,
                color: Colors.grey.shade700))));
  }
}
