import 'package:flutter/material.dart';
import 'package:info_keeper/app/models/home/home_item.dart';
import 'package:info_keeper/app/providers/chat_provider.dart';
import 'package:provider/provider.dart';
import 'package:swipe/swipe.dart';

class ChatView extends StatelessWidget {
  final HomeItem homeItem;
  const ChatView({super.key, required this.homeItem});

  @override
  Widget build(BuildContext context) {
    return ListenableProvider<ChatProvider>(
      create: (context) => ChatProvider(),
      dispose: (context, value) => value.dispose(),
      child: Swipe(
          onSwipeRight: () {},
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(),
            body: _Body(),
          )),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -1 * MediaQuery.of(context).viewInsets.bottom),
      child: ListView(),
    );
  }
}
