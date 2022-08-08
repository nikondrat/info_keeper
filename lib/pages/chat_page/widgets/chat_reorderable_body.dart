import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/chat/chat.dart';
import 'package:info_keeper/pages/chat_page/widgets/chat_body.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ChatPageReorderableBody extends StatelessWidget {
  final RxList pinnedMessages;
  final List selectedMessages;
  final TextEditingController contentController;
  final RxInt selectedMessageCount;
  final BoxConstraints constraints;
  final FocusNode textFieldFocusNode;
  final RxBool editMessage;
  final RxBool isShowColorSelector;
  final AutoScrollController autoScrollController;
  final RxInt selectedMessage;
  final RxBool showDate;
  final RxBool splitMessages;
  final TextEditingController titleController;
  const ChatPageReorderableBody(
      {Key? key,
      required this.autoScrollController,
      required this.constraints,
      required this.contentController,
      required this.editMessage,
      required this.isShowColorSelector,
      required this.pinnedMessages,
      required this.selectedMessage,
      required this.selectedMessageCount,
      required this.selectedMessages,
      required this.showDate,
      required this.splitMessages,
      required this.textFieldFocusNode,
      required this.titleController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
        scrollController: autoScrollController,
        onReorder: (oldIndex, newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }

          var message = Controller
              .to
              .all[Controller.to.selectedFolder.value]
              .directoryChildrens[Controller.to.selectedElementIndex.value]
              .messages!
              .removeAt(oldIndex);
          Controller
              .to
              .all[Controller.to.selectedFolder.value]
              .directoryChildrens[Controller.to.selectedElementIndex.value]
              .messages!
              .insert(newIndex, message);

          Controller.to.change(Chat(
              messages: Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .messages));
        },
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        physics: const BouncingScrollPhysics(),
        itemCount: Controller
            .to
            .all[Controller.to.selectedFolder.value]
            .directoryChildrens[Controller.to.selectedElementIndex.value]
            .messages!
            .length,
        itemBuilder: (context, messageIndex) {
          return ChatPageBodyElement(
              pinnedMessages: pinnedMessages,
              key: Key(messageIndex.toString()),
              selectedMessages: selectedMessages,
              contentController: contentController,
              selectedMessageCount: selectedMessageCount,
              constraints: constraints,
              textFieldFocusNode: textFieldFocusNode,
              editMessage: editMessage,
              isShowColorSelector: isShowColorSelector,
              messageIndex: messageIndex,
              scrollController: autoScrollController,
              selectedMessage: selectedMessage,
              showDate: showDate,
              splitMessages: splitMessages,
              titleController: titleController);
        });
  }
}
