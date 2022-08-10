import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/pages/chat_page/widgets/chat_body.dart';
import 'package:intl/intl.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ChatPageShownDateBody extends StatelessWidget {
  final RxList messages;
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
  const ChatPageShownDateBody(
      {Key? key,
      required this.messages,
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
    return GroupedListView(
        controller: autoScrollController,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        physics: const BouncingScrollPhysics(),
        floatingHeader: true,
        itemComparator: (dynamic item1, dynamic item2) =>
            item2.dateTime.compareTo(item1.dateTime),
        groupComparator: (dynamic value1, dynamic value2) =>
            value2.compareTo(value1),
        groupSeparatorBuilder: (dynamic value) {
          var months = [
            'December',
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July',
            'August',
            'September',
            'October',
            'November',
          ];
          DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');

          DateTime dateTime = format.parse(value);

          return LayoutBuilder(
            builder: (context, constraints) => Container(
              margin: EdgeInsets.symmetric(
                  vertical: 6, horizontal: constraints.maxWidth * 0.38),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${months[dateTime.month]} ${dateTime.day}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
        itemBuilder: (context, dynamic element) => ChatPageBodyElement(
            pinnedMessages: pinnedMessages,
            selectedMessages: selectedMessages,
            selectedMessageCount: selectedMessageCount,
            contentController: contentController,
            textFieldFocusNode: textFieldFocusNode,
            constraints: constraints,
            isShowColorSelector: isShowColorSelector,
            editMessage: editMessage,
            messageIndex: element.location.selectedMessageIndex,
            scrollController: autoScrollController,
            selectedMessage: selectedMessage,
            showDate: showDate,
            splitMessages: splitMessages,
            titleController: titleController),
        elements: Controller
            .to
            .all[Controller.to.selectedFolder.value]
            .directoryChildrens[Controller.to.selectedElementIndex.value]
            .messages!,
        groupBy: (dynamic element) => element?.dateTime);
  }
}
