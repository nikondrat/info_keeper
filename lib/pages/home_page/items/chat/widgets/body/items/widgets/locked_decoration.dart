import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';

class LockedDecorationWidget extends StatelessWidget {
  final Message message;
  const LockedDecorationWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(6)),
      child: const Center(child: Icon(Icons.lock_outline)),
    );
  }
}
