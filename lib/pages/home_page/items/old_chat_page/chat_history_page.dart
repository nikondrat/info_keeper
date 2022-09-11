import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:info_keeper/themes/default/default.dart';

class ChatHistoryPage extends StatelessWidget {
  final List history;
  const ChatHistoryPage({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          splashRadius: 20,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          itemCount: history.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return LayoutBuilder(
              builder: (context, constraints) => GestureDetector(
                onTap: () {
                  Get.back();
                  Clipboard.setData(ClipboardData(text: history[index]));
                  Get.snackbar('Done', 'The message has been copied',
                      shouldIconPulse: true,
                      icon: const Icon(Icons.done),
                      margin: const EdgeInsets.all(10),
                      duration: const Duration(seconds: 1),
                      maxWidth: constraints.maxWidth * 0.8,
                      isDismissible: true,
                      snackPosition: SnackPosition.BOTTOM);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: messageColors[5]),
                  child: Text(history[index]),
                ),
              ),
            );
          }),
    );
  }
}
