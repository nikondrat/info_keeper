import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:info_keeper/model/types/home_item.dart';

class HomeBodyItemChildBody extends StatelessWidget {
  final HomeItem homeItem;
  final String term;
  final Widget? verticalChild;
  final Widget? horizontalChild;
  const HomeBodyItemChildBody(
      {Key? key,
      required this.homeItem,
      required this.term,
      this.verticalChild,
      this.horizontalChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Row horizontal = Row(
      children: [
        homeItem.isPinned
            ? const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(Icons.push_pin_outlined),
              )
            : const SizedBox(),
        homeItem.isLink
            ? const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(Icons.subdirectory_arrow_left),
              )
            : const SizedBox(),
        homeItem.isDublicated
            ? const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(Icons.copy_all),
              )
            : const SizedBox(),
        Expanded(
          child: ParsedText(
            regexOptions: const RegexOptions(
                multiLine: true, unicode: true, dotAll: true),
            text: homeItem.name,
            parse: [
              MatchText(
                  pattern: '([$term])',
                  type: ParsedType.CUSTOM,
                  onTap: (text) => null,
                  style: const TextStyle(color: Colors.blue)),
            ],
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.headline6!.color),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        horizontalChild ?? const SizedBox()
      ],
    );

    return verticalChild != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [horizontal, verticalChild!],
          )
        : horizontal;
  }
}
