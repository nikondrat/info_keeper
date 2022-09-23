import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:get/get.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MessageWidgetText extends StatelessWidget {
  final String text;
  final String searchQuery;
  final int? maxLines;
  const MessageWidgetText(
      {super.key,
      required this.text,
      required this.searchQuery,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return ParsedText(
        maxLines: maxLines,
        regexOptions: const RegexOptions(
            multiLine: true, unicode: true, dotAll: true, caseSensitive: true),
        text: text,
        overflow: maxLines != null ? TextOverflow.ellipsis : TextOverflow.clip,
        style: const TextStyle(color: Colors.black),
        parse: [
          MatchText(
              type: ParsedType.EMAIL,
              onTap: (email) => launchUrlString('mailto:$email'),
              style: const TextStyle(color: Colors.blue)),
          // MatchText(
          //     type: ParsedType.PHONE,
          //     onTap: (phone) => launchUrlString('tel:$phone'),
          //     style: const TextStyle(color: Colors.blue)),
          MatchText(
              type: ParsedType.URL,
              onTap: (url) =>
                  launchUrlString(url, mode: LaunchMode.externalApplication),
              style: const TextStyle(color: Colors.blue)),
          MatchText(
              pattern: '([$searchQuery])',
              type: ParsedType.CUSTOM,
              onTap: (text) => null,
              style: const TextStyle(color: Colors.blue)),
          MatchText(
              pattern: r"\B(#|@)+([\w]+)\b",
              type: ParsedType.CUSTOM,
              onTap: (hashtag) {
                final ChatController controller = Get.find();
                controller.isSearch.value = true;
                controller.searchController.text = hashtag;
              },
              style: const TextStyle(color: Colors.blue))
        ]);
  }
}
