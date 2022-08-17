import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/chat/chat.dart';
import 'package:info_keeper/model/types/location_element.dart';
import 'package:info_keeper/pages/chat_page/chat_history_page.dart';
import 'package:info_keeper/pages/chat_page/widgets/message_menu/chat_menu_item.dart';
import 'package:info_keeper/pages/chat_page/widgets/message_menu/chat_message_full_screen.dart';
import 'package:info_keeper/pages/vault_page/vault_page.dart';
import 'package:info_keeper/widgets/notifications.dart';

class ChatPageMenu extends StatelessWidget {
  final BoxConstraints constraints;
  final RxBool isShowColorSelector;
  final RxBool showDate;
  final RxBool editMessage;
  final RxBool splitMessages;
  final RxInt selectedMessage;
  final FocusNode textFieldFocusNode;
  final List selectedMessages;
  final TextEditingController contentController;
  final TextEditingController titleController;
  final RxInt selectedMessageCount;
  final RxList pinnedMessages;
  final RxBool moveMessage;
  const ChatPageMenu(
      {Key? key,
      required this.constraints,
      required this.showDate,
      required this.isShowColorSelector,
      required this.selectedMessageCount,
      required this.splitMessages,
      required this.moveMessage,
      required this.selectedMessages,
      required this.titleController,
      required this.editMessage,
      required this.textFieldFocusNode,
      required this.contentController,
      required this.pinnedMessages,
      required this.selectedMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 2, color: Colors.grey.shade300, spreadRadius: 1)
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6), bottomLeft: Radius.circular(6))),
      width: constraints.maxWidth * 0.5,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ChatPageMenuItem(
                function: () {
                  Clipboard.setData(ClipboardData(
                      text: Controller
                          .to
                          .all[Controller.to.selectedFolder.value]
                          .directoryChildrens[
                              Controller.to.selectedElementIndex.value]
                          .messages[selectedMessage.value]
                          .messageText));
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
                icon: const Icon(Icons.copy),
                text: 'Copy'),
            ChatPageMenuItem(
                function: () {
                  Navigator.pop(context);
                  editMessage.value = true;
                  contentController.value = TextEditingValue(
                      text: Controller
                          .to
                          .all[Controller.to.selectedFolder.value]
                          .directoryChildrens[
                              Controller.to.selectedElementIndex.value]
                          .messages[selectedMessage.value]
                          .messageText);
                  titleController.value = TextEditingValue(
                      text: Controller
                          .to
                          .all[Controller.to.selectedFolder.value]
                          .directoryChildrens[
                              Controller.to.selectedElementIndex.value]
                          .messages[selectedMessage.value]
                          .title);
                  textFieldFocusNode.requestFocus();
                },
                icon: const Icon(Icons.edit_outlined),
                text: 'Edit'),
            ChatPageMenuItem(
                function: () {
                  Navigator.pop(context);
                  isShowColorSelector.value = true;
                },
                icon: const Icon(Icons.brush_outlined),
                text: 'Highlite'),
            ChatPageMenuItem(
                function: () {
                  Navigator.pop(context);
                  Get.to(() => ChatHistoryPage(
                        history: Controller
                            .to
                            .all[Controller.to.selectedFolder.value]
                            .directoryChildrens[
                                Controller.to.selectedElementIndex.value]
                            .messages[selectedMessage.value]
                            .history,
                      ));
                },
                icon: const Icon(Icons.history),
                text: 'Edit history'),
            ChatPageMenuItem(
                function: () {
                  Navigator.pop(context);
                  splitMessages.value = true;
                },
                icon: const Icon(Icons.forum_outlined),
                text: 'Unite messages'),
            ChatPageMenuItem(
                icon: const Icon(Icons.drag_handle),
                text: 'Move message',
                function: () {
                  Navigator.pop(context);
                  Controller.to.firstSelectedMessage = selectedMessage.value;
                  moveMessage.value = true;
                }),
            ChatPageMenuItem(
                icon: const Icon(Icons.open_in_full),
                text: 'Collapse message',
                function: () {
                  Navigator.pop(context);

                  List messages = Controller
                      .to
                      .all[Controller.to.selectedFolder.value]
                      .directoryChildrens[
                          Controller.to.selectedElementIndex.value]
                      .messages;
                  messages[selectedMessage.value].isCollapsed =
                      !messages[selectedMessage.value].isCollapsed;
                  Controller.to.change(Chat(messages: messages.obs));
                }),
            ChatPageMenuItem(
                function: () {
                  Navigator.pop(context);
                  Get.to(() => ChatPageMessageInFullScreen(
                      moveMessage: moveMessage,
                      selectedMessageCount: selectedMessageCount,
                      pinnedMessages: pinnedMessages,
                      selectedMessages: selectedMessages,
                      splitMessages: splitMessages,
                      showDate: showDate,
                      selected: selectedMessage,
                      dateTime: Controller
                          .to
                          .all[Controller.to.selectedFolder.value]
                          .directoryChildrens[
                              Controller.to.selectedElementIndex.value]
                          .messages[selectedMessage.value]
                          .dateTime,
                      message: Controller
                          .to
                          .all[Controller.to.selectedFolder.value]
                          .directoryChildrens[
                              Controller.to.selectedElementIndex.value]
                          .messages[selectedMessage.value],
                      isShowColorSelector: isShowColorSelector));
                },
                icon: const Icon(Icons.open_in_full),
                text: 'Full screen'),
            ChatPageMenuItem(
                function: () {
                  Navigator.pop(context);

                  List messages = Controller
                      .to
                      .all[Controller.to.selectedFolder.value]
                      .directoryChildrens[
                          Controller.to.selectedElementIndex.value]
                      .messages;

                  messages[selectedMessage.value].isPinned =
                      !messages[selectedMessage.value].isPinned;

                  messages[selectedMessage.value].isPinned
                      ? pinnedMessages.add(messages[selectedMessage.value])
                      : pinnedMessages.removeAt(0);

                  Controller.to.change(Chat(
                      messages: messages.obs, pinnedMessages: pinnedMessages));
                },
                icon: const Icon(Icons.push_pin_outlined),
                text: Controller
                        .to
                        .all[Controller.to.selectedFolder.value]
                        .directoryChildrens[
                            Controller.to.selectedElementIndex.value]
                        .messages[selectedMessage.value]
                        .isPinned
                    ? 'Unpin'
                    : 'Pin'),
            ChatPageMenuItem(
                function: () {
                  Navigator.pop(context);

                  List messages = Controller
                      .to
                      .all[Controller.to.selectedFolder.value]
                      .directoryChildrens[
                          Controller.to.selectedElementIndex.value]
                      .messages;

                  messages[selectedMessage.value].isFavorite =
                      !messages[selectedMessage.value].isFavorite;

                  List favorites = Controller
                      .to
                      .all[Controller.to.selectedFolder.value]
                      .directoryChildrens[
                          Controller.to.selectedElementIndex.value]
                      .favorites;

                  messages[selectedMessage.value].isFavorite
                      ? favorites.add(messages[selectedMessage.value])
                      : favorites.remove(messages[selectedMessage.value]);

                  Controller.to.change(
                      Chat(favorites: favorites.obs, messages: messages.obs));
                },
                icon: const Icon(Icons.star_outline),
                text: Controller
                        .to
                        .all[Controller.to.selectedFolder.value]
                        .directoryChildrens[
                            Controller.to.selectedElementIndex.value]
                        .messages[selectedMessage.value]
                        .isFavorite
                    ? 'Remove from favorites'
                    : 'Add to favorites'),
            ChatPageMenuItem(
                function: () {
                  Navigator.pop(context);

                  if (Controller.to.password.isNotEmpty) {
                    List messages = Controller
                        .to
                        .all[Controller.to.selectedFolder.value]
                        .directoryChildrens[
                            Controller.to.selectedElementIndex.value]
                        .messages;

                    messages[selectedMessage.value].isLocked = true;
                    messages[selectedMessage.value].isUnlocked = false;

                    Controller.to.change(Chat(messages: messages.obs));
                  } else {
                    Get.to(() => VaultPage(
                        selectedElement: selectedMessage, first: true));
                  }
                },
                icon: const Icon(Icons.lock_outline),
                text: 'Lock message'),
            Notifications(
              name: Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .name,
              messageText: Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .messages[selectedMessage.value]
                  .messageText,
              locElement: LocationElement(
                  inDirectory: Controller.to.selectedFolder.value,
                  selectedMessageIndex: selectedMessage.value,
                  index: Controller.to.selectedElementIndex.value),
            ),
            // ChatPageMenuItem(
            //     function: () {
            //       Navigator.pop(context);
            //     },
            //     icon: const Icon(Icons.undo),
            //     text: 'Undo'),
            ChatPageMenuItem(
                function: () {
                  Navigator.pop(context);

                  var message = Controller
                      .to
                      .all[Controller.to.selectedFolder.value]
                      .directoryChildrens[
                          Controller.to.selectedElementIndex.value]
                      .messages
                      .removeAt(selectedMessage.value);

                  Controller.to.trashElements.add(message);
                  Controller.to.setData();
                  // print(selectedMessage.value);
                  // messages.removeAt(0);
                  // Controller.to.change(Chat(messages: messages));
                },
                icon: const Icon(Icons.delete_outline),
                text: 'Move to trash'),
          ]),
    );
  }
}
