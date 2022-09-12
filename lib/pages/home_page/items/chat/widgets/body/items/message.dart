import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/widgets/item_decoration.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/menu/menu.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final String searchQuery;
  final double elevation;
  const MessageWidget(
      {Key? key,
      required this.message,
      this.elevation = 0,
      required this.searchQuery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemDecoration(
        index: message.location.itemIndex!,
        color: message.color,
        elevation: elevation,
        padding: EdgeInsets.zero,
        dateTime: message.dateTime,
        child: GestureDetector(
          onTap: () => showBarModalBottomSheet(
              context: context,
              builder: (context) => MessageMenuWidget(message: message)),
          child: message.title.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.grey.shade400),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SubstringHighlight(
                              text: message.title, term: searchQuery),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SubstringHighlight(
                            text: message.content, term: searchQuery),
                      )
                    ])
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ParsedText(
                    regexOptions: const RegexOptions(
                        multiLine: true, unicode: true, dotAll: true),
                    text: message.content,
                    style: const TextStyle(color: Colors.black),
                    parse: [
                      MatchText(
                          type: ParsedType.EMAIL,
                          onTap: (email) => launchUrlString('mailto:$email'),
                          style: const TextStyle(color: Colors.blue)),
                      MatchText(
                          type: ParsedType.URL,
                          onTap: (url) => launchUrlString(url),
                          style: const TextStyle(color: Colors.blue)),
                      MatchText(
                          type: ParsedType.PHONE,
                          onTap: (phone) => launchUrlString('tel:$phone'),
                          style: const TextStyle(color: Colors.blue)),
                      MatchText(
                          pattern: '([$searchQuery])',
                          type: ParsedType.CUSTOM,
                          onTap: (text) => null,
                          style: const TextStyle(color: Colors.blue)),
                      MatchText(
                          pattern: r"\B#+([\w]+)\b",
                          type: ParsedType.CUSTOM,
                          onTap: (hashtag) {
                            final ChatController controller = Get.find();
                            controller.isSearch.value = true;
                            controller.searchController.text = hashtag;
                          },
                          style: const TextStyle(color: Colors.blue))
                    ],
                  ),
                ),
        ));
  }
}
