import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/message/widgets/content_text.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/widgets/item_decoration.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/widgets/locked_decoration.dart';
import 'package:swipe_to/swipe_to.dart';

class MessageWidgetBody extends StatelessWidget {
  final Message message;
  final String searchQuery;
  final double elevation;
  const MessageWidgetBody(
      {Key? key,
      required this.message,
      this.elevation = 0,
      required this.searchQuery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget title = Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.grey.shade400),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              MessageWidgetText(text: message.title, searchQuery: searchQuery)),
    );

    Widget content = Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpandableNotifier(
            child: ScrollOnExpand(
                child: Row(children: [
          message.content.split(' ').length > 100
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpandableButton(
                    child: const Icon(Icons.close_fullscreen),
                  ),
                )
              : const SizedBox(),
          Expanded(
              child: ExpandablePanel(
                  collapsed: MessageWidgetText(
                      text: message.content,
                      maxLines:
                          message.content.split(' ').length > 100 ? 3 : null,
                      searchQuery: searchQuery),
                  expanded: MessageWidgetText(
                      text: message.content, searchQuery: searchQuery))),
          message.isFavorite
              ? Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.grey),
                  child: const Icon(Icons.star, color: Colors.yellowAccent))
              : const SizedBox(),
          message.isUnlocked
              ? Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.grey),
                  child: const Icon(Icons.lock_outline))
              : const SizedBox(),
        ]))));

    return message.isLocked
        ? LockedDecorationWidget(message: message)
        : SwipeTo(
            onRightSwipe: () {},
            child: ItemDecoration(
                index: message.location.itemIndex!,
                color: message.color,
                elevation: elevation,
                padding: EdgeInsets.zero,
                dateTime: message.dateTime,
                child: message.title.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [title, content])
                    : content),
          );
  }
}
