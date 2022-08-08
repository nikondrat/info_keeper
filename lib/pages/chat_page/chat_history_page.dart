import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/theme.dart';

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
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: messageColors[5]),
              child: Text(history[index]),
            );
          }),
    );
  }
}
