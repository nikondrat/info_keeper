import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/pages/chat_page/widgets/type/chat_message.dart';

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
          itemCount: history.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return MessageWidgetBody(
              message: history[index],
            );
          }),
    );
  }
}
