import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:substring_highlight/substring_highlight.dart';

class HomeBodyItemChildBody extends StatelessWidget {
  final HomeItem homeItem;
  final String term;
  const HomeBodyItemChildBody(
      {Key? key, required this.homeItem, required this.term})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
          child: SubstringHighlight(
            term: term,
            textStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
            text: homeItem.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
