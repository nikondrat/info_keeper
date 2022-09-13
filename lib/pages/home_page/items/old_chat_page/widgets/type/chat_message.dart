import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/model/types/home/chat/old_chat.dart';
import 'package:info_keeper/pages/home_page/items/old_chat_page/widgets/message_menu/chat_menu.dart';
import 'package:info_keeper/pages/trash_page/trash_element.dart';
import 'package:info_keeper/themes/default/default.dart';
import 'package:intl/intl.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:swipe_to/swipe_to.dart';

class MessageWidget extends StatelessWidget {
  final AutoScrollController? scrollController;
  final GlobalKey? messageKey;
  final BoxConstraints? constraints;
  final TextEditingController? titleController;
  final RxBool? editMessage;
  final FocusNode? textFieldFocusNode;
  final RxInt selected;
  final TextEditingController? contentController;
  final RxInt? selectedMessage;
  final RxBool showDate;
  final bool fullScreen;
  final Message message;
  final String dateTime;
  final RxBool splitMessages;
  final RxBool isShowColorSelector;
  final RxInt selectedMessagesCount;
  final List selectedMessages;
  final RxList pinnedMessages;
  final RxBool moveMessage;
  const MessageWidget(
      {Key? key,
      this.messageKey,
      this.scrollController,
      this.constraints,
      required this.selected,
      this.contentController,
      required this.moveMessage,
      required this.selectedMessagesCount,
      this.editMessage,
      this.selectedMessage,
      this.titleController,
      this.textFieldFocusNode,
      required this.message,
      required this.showDate,
      required this.dateTime,
      required this.splitMessages,
      required this.isShowColorSelector,
      required this.selectedMessages,
      required this.pinnedMessages,
      this.fullScreen = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value]
                .child
                .value
                .messages[message.location.itemIndex!]
                .isLocked &&
            !Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value]
                .child
                .value
                .messages[message.location.itemIndex!]
                .isUnlocked
        ? GestureDetector(
            key: messageKey,
            onTap: () {
              selected.value = message.location.itemIndex!;
              if (moveMessage.value) {
                var message = Controller
                    .to
                    .all[Controller.to.selectedFolder.value]
                    .childrens[Controller.to.selectedElementIndex.value]
                    .child
                    .value
                    .messages
                    .removeAt(Controller.to.firstSelectedMessage);
                Controller
                    .to
                    .all[Controller.to.selectedFolder.value]
                    .childrens[Controller.to.selectedElementIndex.value]
                    .child
                    .value
                    .messages
                    .insert(selected.value, message);
                moveMessage.value = false;
              }
              // Get.to(() => VaultPage(
              //       isChat: true,
              //       selectedElement: selectedMessage!,
              //     ));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(6)),
              child: const Center(child: Icon(Icons.lock_outline)),
              // child: Row(
              //   children: [
              //     const Icon(Icons.lock_outline),
              //     Text(Controller
              //         .to
              //         .all[Controller.to.selectedFolder.value]
              //         .childrens[
              //             Controller.to.selectedElementIndex.value]
              //         .messages[message.location.selectedMessageIndex]
              //         .title),
              //   ],
              // ),
            ),
          )
        : fullScreen
            ? MessageWidgetChild(
                moveMessage: moveMessage,
                scrollController: scrollController,
                selected: selected,
                contentController: contentController,
                selectedMessagesCount: selectedMessagesCount,
                editMessage: editMessage,
                selectedMessage: selectedMessage,
                titleController: titleController,
                textFieldFocusNode: textFieldFocusNode,
                constraints: constraints,
                message: message,
                showDate: showDate,
                dateTime: dateTime,
                splitMessages: splitMessages,
                isShowColorSelector: isShowColorSelector,
                selectedMessages: selectedMessages,
                pinnedMessages: pinnedMessages)
            : SwipeTo(
                key: messageKey,
                onRightSwipe: () {
                  selectedMessage!.value = message.location.itemIndex!;
                  editMessage!.value = true;
                  contentController!.value = TextEditingValue(
                      text: Controller
                          .to
                          .all[Controller.to.selectedFolder.value]
                          .childrens[Controller.to.selectedElementIndex.value]
                          .child
                          .value
                          .messages[selectedMessage!.value]
                          .title);
                  titleController!.value = TextEditingValue(
                      text: Controller
                          .to
                          .all[Controller.to.selectedFolder.value]
                          .childrens[Controller.to.selectedElementIndex.value]
                          .child
                          .value
                          .messages[selectedMessage!.value]
                          .title);
                  textFieldFocusNode!.requestFocus();
                },
                child: MessageWidgetChild(
                    moveMessage: moveMessage,
                    constraints: constraints,
                    scrollController: scrollController,
                    selected: selected,
                    contentController: contentController,
                    selectedMessagesCount: selectedMessagesCount,
                    editMessage: editMessage,
                    selectedMessage: selectedMessage,
                    titleController: titleController,
                    textFieldFocusNode: textFieldFocusNode,
                    message: message,
                    showDate: showDate,
                    dateTime: dateTime,
                    splitMessages: splitMessages,
                    isShowColorSelector: isShowColorSelector,
                    selectedMessages: selectedMessages,
                    pinnedMessages: pinnedMessages)));
  }
}

class MessageWidgetChild extends StatelessWidget {
  final AutoScrollController? scrollController;
  final BoxConstraints? constraints;
  final TextEditingController? titleController;
  final RxBool? editMessage;
  final FocusNode? textFieldFocusNode;
  final RxInt selected;
  final TextEditingController? contentController;
  final RxInt? selectedMessage;
  final RxBool showDate;
  final bool fullScreen;
  final Message message;
  final String dateTime;
  final RxBool splitMessages;
  final RxBool isShowColorSelector;
  final RxInt selectedMessagesCount;
  final List selectedMessages;
  final RxList pinnedMessages;
  final RxBool moveMessage;
  const MessageWidgetChild(
      {Key? key,
      required this.scrollController,
      required this.constraints,
      required this.selected,
      required this.moveMessage,
      required this.contentController,
      required this.selectedMessagesCount,
      required this.editMessage,
      required this.selectedMessage,
      required this.titleController,
      required this.textFieldFocusNode,
      required this.message,
      required this.showDate,
      required this.dateTime,
      required this.splitMessages,
      required this.isShowColorSelector,
      required this.selectedMessages,
      required this.pinnedMessages,
      this.fullScreen = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isShowColorSelector.value != true &&
            splitMessages.value != true &&
            fullScreen != true &&
            moveMessage.value != true) {
          selectedMessage!.value = message.location.itemIndex!;

          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => ChatPageMenu(
                  moveMessage: moveMessage,
                  pinnedMessages: pinnedMessages,
                  selectedMessages: selectedMessages,
                  selectedMessageCount: selectedMessagesCount,
                  constraints: constraints!,
                  showDate: showDate,
                  isShowColorSelector: isShowColorSelector,
                  splitMessages: splitMessages,
                  titleController: titleController!,
                  editMessage: editMessage!,
                  textFieldFocusNode: textFieldFocusNode!,
                  contentController: contentController!,
                  selectedMessage: selectedMessage!));
        }
        selected.value = message.location.itemIndex!;
        if (moveMessage.value) {
          var message = Controller
              .to
              .all[Controller.to.selectedFolder.value]
              .childrens[Controller.to.selectedElementIndex.value]
              .child
              .value
              .messages
              .removeAt(Controller.to.firstSelectedMessage);
          Controller
              .to
              .all[Controller.to.selectedFolder.value]
              .childrens[Controller.to.selectedElementIndex.value]
              .child
              .value
              .messages
              .insert(selected.value, message);
          moveMessage.value = false;
        }

        if (splitMessages.value) {
          List messages = Controller
              .to
              .all[Controller.to.selectedFolder.value]
              .childrens[Controller.to.selectedElementIndex.value]
              .child
              .value
              .messages;
          message.isSelected = !message.isSelected;
          if (message.isSelected) {
            selectedMessages.add(message);
            selectedMessagesCount.value += 1;
          } else {
            selectedMessages.remove(message);
            selectedMessagesCount.value -= 1;
          }
          // print(selectedMessages);
          messages[message.location.itemIndex!] = message;
          Controller.to.change(
            ChatItem(messages: messages.obs),
          );
        }
      },
      child: MessageWidgetBody(
        message: message,
        splitMessages: splitMessages,
        fullScreen: fullScreen,
        showDate: showDate,
        selected: selected,
        dateTime: dateTime,
      ),
    );
  }
}

class MessageWidgetBody extends StatelessWidget {
  final int? index;
  final bool? isTrash;
  final bool fullScreen;
  final RxInt? selected;
  final RxBool? splitMessages;
  final Message message;
  final RxBool? showDate;
  final String? dateTime;
  final String term;

  const MessageWidgetBody(
      {Key? key,
      this.index,
      this.isTrash,
      this.fullScreen = false,
      this.selected,
      this.splitMessages,
      required this.message,
      this.term = '',
      this.showDate,
      this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime time = format.parse(dateTime!);
    final isShowRestoreMenu = false.obs;

    Widget body = TrashElement(
        isShowRestoreMenu: isShowRestoreMenu,
        index: index,
        isMessage: true,
        child: GestureDetector(
          onLongPress: isTrash != null
              ? () {
                  isShowRestoreMenu.value = true;
                }
              : null,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: fullScreen ? MainAxisSize.min : MainAxisSize.max,
              children: [
                // message.title.isNotEmpty
                //     ? Container(
                //         padding: const EdgeInsets.all(4),
                //         decoration: BoxDecoration(
                //             color: const Color(0xFF9FA8A8),
                //             borderRadius: BorderRadius.circular(6)),
                //         child:
                //             SubstringHighlight(text: message.title, term: term),
                //       )
                //     : Container(),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: splitMessages != null
                            ? splitMessages!.value && message.isSelected ||
                                    message.isUnlocked
                                ? Border.all()
                                : null
                            : null,
                        color: splitMessages != null
                            ? splitMessages!.value && message.isSelected
                                ? Colors.white
                                : messageColors[message.color]
                            : messageColors[message.color]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Expanded(
                            //     child: SubstringHighlight(
                            //   textStyle: const TextStyle(
                            //       color: Colors.black, fontSize: 16),
                            //   text: message.content,
                            //   maxLines: selected != null &&
                            //           Controller
                            //                   .to
                            //                   .all[Controller
                            //                       .to.selectedFolder.value]
                            //                   .childrens[Controller.to
                            //                       .selectedElementIndex.value]
                            //                   .child
                            //                   .value
                            //                   .messages[selected!.value]
                            //                   .type ==
                            //               AllType.chatMessage
                            //       ? Controller
                            //               .to
                            //               .all[Controller
                            //                   .to.selectedFolder.value]
                            //               .childrens[Controller
                            //                   .to.selectedElementIndex.value]
                            //               .child
                            //               .value
                            //               .messages[selected!.value]
                            //               .isCollapsed
                            //           ? 6
                            //           : null
                            //       : null,
                            //   term: term,
                            // )),
                            Column(
                              children: [
                                message.isUnlocked
                                    ? const Icon(Icons.lock_open_outlined)
                                    : const SizedBox(),
                                message.isFavorite
                                    ? const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ],
                        ),
                        showDate != null
                            ? showDate!.value
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      '${time.hour}:${time.minute}',
                                      style: TextStyle(
                                          color: Colors.grey.shade600),
                                    ),
                                  )
                                : const SizedBox()
                            : const SizedBox()
                      ],
                    ))
              ]),
        ));

    if (term.isNotEmpty) {
      return LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: message.content));
              Navigator.pop(context);
              Get.snackbar('Done', 'The message has been copied',
                  shouldIconPulse: true,
                  icon: const Icon(Icons.done),
                  margin: const EdgeInsets.all(10),
                  duration: const Duration(seconds: 1),
                  maxWidth: constraints.maxWidth * 0.8,
                  isDismissible: true,
                  snackPosition: SnackPosition.BOTTOM);
            },
            child: body),
      );
    }

    return body;
  }
}
