import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/widgets/item_decoration.dart';

class ChatMessageHistoryPage extends StatelessWidget {
  final List history;
  const ChatMessageHistoryPage({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              splashRadius: 20,
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back))),
      body: ListView.builder(
          itemCount: history.length,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.back();
                Clipboard.setData(ClipboardData(text: history[index]));
                Get.snackbar('Done', 'The message content has been copied',
                    shouldIconPulse: true,
                    icon: const Icon(Icons.done),
                    margin: const EdgeInsets.all(10),
                    duration: const Duration(seconds: 1),
                    isDismissible: true,
                    snackPosition: SnackPosition.BOTTOM);
              },
              child: ItemDecoration(
                  index: index,
                  dateTime: DateTime.now(),
                  child: AutoSizeText(history[index],
                      style: Theme.of(context).textTheme.bodyText1)),
            );
          }),
    );
  }
}
