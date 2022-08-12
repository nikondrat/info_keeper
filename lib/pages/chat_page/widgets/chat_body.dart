import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/pages/chat_page/widgets/chat_reorderable_body.dart';
import 'package:info_keeper/pages/chat_page/widgets/chat_shown_date_body.dart';
import 'package:info_keeper/pages/chat_page/widgets/type/chat_file.dart';
import 'package:info_keeper/pages/chat_page/widgets/type/chat_image.dart';
import 'package:info_keeper/pages/chat_page/widgets/type/chat_message.dart';
import 'package:info_keeper/pages/chat_page/widgets/type/chat_voice.dart';
import 'package:intl/intl.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ChatPageBody extends StatelessWidget {
  final AutoScrollController autoScrollController;
  final RxBool isShowColorSelector;
  final RxBool editMessage;
  final RxBool showDate;
  final RxInt selectedMessage;
  final RxBool splitMessages;
  final FocusNode textFieldFocusNode;
  final RxInt selectedMessageCount;
  final TextEditingController contentController;
  final TextEditingController titleController;
  final List selectedMessages;
  final RxList pinnedMessages;

  const ChatPageBody(
      {Key? key,
      required this.autoScrollController,
      required this.selectedMessageCount,
      required this.isShowColorSelector,
      required this.splitMessages,
      required this.editMessage,
      required this.textFieldFocusNode,
      required this.showDate,
      required this.selectedMessages,
      required this.contentController,
      required this.titleController,
      required this.pinnedMessages,
      required this.selectedMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -1 * MediaQuery.of(context).viewInsets.bottom),
      child: LayoutBuilder(
          builder: (context, constraints) => Obx(() => showDate.value
              ? ChatPageShownDateBody(
                  autoScrollController: autoScrollController,
                  constraints: constraints,
                  contentController: contentController,
                  editMessage: editMessage,
                  isShowColorSelector: isShowColorSelector,
                  pinnedMessages: pinnedMessages,
                  selectedMessage: selectedMessage,
                  selectedMessageCount: selectedMessageCount,
                  selectedMessages: selectedMessages,
                  showDate: showDate,
                  splitMessages: splitMessages,
                  textFieldFocusNode: textFieldFocusNode,
                  titleController: titleController)
              // ? ReorderableListView.builder(
              //     scrollController: autoScrollController,
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              //     physics: const BouncingScrollPhysics(),
              //     reverse: true,
              //     onReorder: (oldIndex, newIndex) {
              //       if (oldIndex < newIndex) {
              //         newIndex -= 1;
              //       }
              //       List messages = Controller
              //           .to
              //           .all[Controller.to.selectedFolder.value]
              //           .directoryChildrens[
              //               Controller.to.selectedElementIndex.value]
              //           .messages;

              //       var message = Controller
              //           .to
              //           .all[Controller.to.selectedFolder.value]
              //           .directoryChildrens[
              //               Controller.to.selectedElementIndex.value]
              //           .messages
              //           .removeAt(oldIndex);

              //       messages.insert(newIndex, message);

              //       Controller.to.change(Chat(messages: messages.obs));
              //     },
              //     itemCount: Controller
              //         .to
              //         .all[Controller.to.selectedFolder.value]
              //         .directoryChildrens[chatIndex]
              //         .messages
              //         .length,
              //     itemBuilder: (context, messageIndex) {
              //       DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');

              //       DateTime dateTime = format.parse(Controller
              //           .to
              //           .all[Controller.to.selectedFolder.value]
              //           .directoryChildrens[chatIndex]
              //           .messages[messageIndex]
              //           .dateTime);

              //       var month = months[dateTime.month];
              //       var day = dateTime.day;

              //       bool isSameDate = true;

              //       dateWidget() {
              //         return Container(
              //           key: Key(
              //             'date$messageIndex',
              //           ),
              //           margin: EdgeInsets.symmetric(
              //               vertical: 6,
              //               horizontal: constraints.maxWidth * 0.36),
              //           padding: const EdgeInsets.all(4),
              //           alignment: Alignment.center,
              //           decoration: BoxDecoration(
              //               color: const Color.fromARGB(255, 235, 235, 235),
              //               borderRadius: BorderRadius.circular(10)),
              //           child: Text('$month $day'),
              //         );
              //       }

              //       if (messageIndex ==
              //           Controller.to.all[Controller.to.selectedFolder.value]
              //                   .directoryChildrens[chatIndex].messages.length -
              //               1) {
              //         isSameDate = false;
              //       } else {
              //         final String prevDateString = Controller
              //             .to
              //             .all[Controller.to.selectedFolder.value]
              //             .directoryChildrens[chatIndex]
              //             .messages[messageIndex]
              //             .dateTime
              //             .toString();
              //         final DateTime prevDate = DateTime.parse(prevDateString);
              //         isSameDate = dateTime.isSameDate(prevDate);
              //       }

              //       if (messageIndex ==
              //               Controller
              //                       .to
              //                       .all[Controller.to.selectedFolder.value]
              //                       .directoryChildrens[chatIndex]
              //                       .messages
              //                       .length -
              //                   1 ||
              //           !(isSameDate)) {
              //         return Column(key: Key('Column$messageIndex'), children: [
              //           dateWidget(),
              //           ChatPageBodyElement(
              //               selectedMessages: selectedMessages,
              //               key: Key(messageIndex.toString()),
              //               chatIndex: chatIndex,
              //               pinnedMessages: pinnedMessages,
              //               textFieldFocusNode: textFieldFocusNode,
              //               constraints: constraints,
              //               isShowColorSelector: isShowColorSelector,
              //               messageIndex: messageIndex,
              //               scrollController: autoScrollController,
              //               editMessage: editMessage,
              //               selectedMessage: selectedMessage,
              //               contentController: contentController,
              //               showDate: showDate,
              //               selectedMessageCount: selectedMessageCount,
              //               splitMessages: splitMessages,
              //               titleController: titleController),
              //         ]);
              //       } else {
              //         return ChatPageBodyElement(
              //             key: Key(messageIndex.toString()),
              //             chatIndex: chatIndex,
              //             pinnedMessages: pinnedMessages,
              //             selectedMessages: selectedMessages,
              //             selectedMessageCount: selectedMessageCount,
              //             contentController: contentController,
              //             textFieldFocusNode: textFieldFocusNode,
              //             constraints: constraints,
              //             isShowColorSelector: isShowColorSelector,
              //             editMessage: editMessage,
              //             messageIndex: messageIndex,
              //             scrollController: autoScrollController,
              //             selectedMessage: selectedMessage,
              //             showDate: showDate,
              //             splitMessages: splitMessages,
              //             titleController: titleController);
              //       }
              //     })
              : ChatPageReorderableBody(
                  autoScrollController: autoScrollController,
                  constraints: constraints,
                  contentController: contentController,
                  editMessage: editMessage,
                  isShowColorSelector: isShowColorSelector,
                  pinnedMessages: pinnedMessages,
                  selectedMessage: selectedMessage,
                  selectedMessageCount: selectedMessageCount,
                  selectedMessages: selectedMessages,
                  showDate: showDate,
                  splitMessages: splitMessages,
                  textFieldFocusNode: textFieldFocusNode,
                  titleController: titleController))),
    );
  }
}

const String dateFormatter = 'yyyy-MM-dd HH:mm:ss';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}

class ChatPageBodyElement extends StatelessWidget {
  final int messageIndex;
  final AutoScrollController scrollController;
  final TextEditingController titleController;
  final BoxConstraints constraints;
  final RxBool showDate;
  final RxBool splitMessages;
  final RxInt selectedMessage;
  final RxBool isShowColorSelector;
  final RxBool editMessage;
  final RxInt selectedMessageCount;
  final FocusNode textFieldFocusNode;
  final TextEditingController contentController;
  final List selectedMessages;
  final RxList pinnedMessages;

  const ChatPageBodyElement(
      {Key? key,
      required this.selectedMessageCount,
      required this.constraints,
      required this.editMessage,
      required this.contentController,
      required this.isShowColorSelector,
      required this.messageIndex,
      required this.scrollController,
      required this.selectedMessage,
      required this.showDate,
      required this.splitMessages,
      required this.textFieldFocusNode,
      required this.pinnedMessages,
      required this.selectedMessages,
      required this.titleController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (Controller
        .to
        .all[Controller.to.selectedFolder.value]
        .directoryChildrens[Controller.to.selectedElementIndex.value]
        .messages[messageIndex]
        .type) {
      case AllType.chatImage:
        return ChatImageWidget(
            key: ValueKey(messageIndex),
            dateTime: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .messages[messageIndex]
                .dateTime,
            showDate: showDate,
            path: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .messages[messageIndex]
                .path);
      case AllType.chatVoice:
        return ChatVoiceWidget(
          key: ValueKey(messageIndex),
          codec: Controller
              .to
              .all[Controller.to.selectedFolder.value]
              .directoryChildrens[Controller.to.selectedElementIndex.value]
              .messages[messageIndex]
              .codec,
          dateTime: Controller
              .to
              .all[Controller.to.selectedFolder.value]
              .directoryChildrens[Controller.to.selectedElementIndex.value]
              .messages[messageIndex]
              .dateTime,
          showDate: showDate,
          path: Controller
              .to
              .all[Controller.to.selectedFolder.value]
              .directoryChildrens[Controller.to.selectedElementIndex.value]
              .messages[messageIndex]
              .path,
        );
      case AllType.chatMessage:
        return AutoScrollTag(
          index: messageIndex,
          controller: scrollController,
          key: ValueKey(messageIndex),
          child: MessageWidget(
            pinnedMessages: pinnedMessages,
            selectedMessages: selectedMessages,
            selectedMessagesCount: selectedMessageCount,
            scrollController: scrollController,
            titleController: titleController,
            constraints: constraints,
            showDate: showDate,
            textFieldFocusNode: textFieldFocusNode,
            selectedMessage: selectedMessage,
            contentController: contentController,
            editMessage: editMessage,
            splitMessages: splitMessages,
            selected: selectedMessage,
            dateTime: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .messages[messageIndex]
                .dateTime,
            message: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .messages[messageIndex],
            isShowColorSelector: isShowColorSelector,
          ),
        );
      case AllType.chatFile:
        return ChatPageFile(
            key: ValueKey(messageIndex),
            dateTime: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .messages[messageIndex]
                .dateTime,
            showDate: showDate);
      default:
        return Container();
    }
  }
}
