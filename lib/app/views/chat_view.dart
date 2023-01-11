import 'package:flutter/material.dart';
import 'package:info_keeper/app/providers/chat_provider.dart';
import 'package:info_keeper/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:swipe/swipe.dart';

class ChatView extends StatelessWidget {
  // final HomeItem homeItem;
  const ChatView({
    super.key,
    // required this.homeItem
  });

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
            body: const _Body(),
            bottomNavigationBar: const _BottomBar(),
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

class _BottomBar extends StatelessWidget {
  const _BottomBar();

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
        offset: Offset(0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: BottomAppBar(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * .14),
              child: TextField(
                maxLines: null,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    hintText: S.of(context).write_text,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.grey.shade300),
                    prefixIcon: IconButton(
                        onPressed: () {},
                        splashRadius: 20,
                        icon: Icon(Icons.title,
                            color: Theme.of(context).primaryColor)),
                    suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          splashRadius: 20,
                          onPressed: () {},
                          icon: Icon(Icons.attach_file,
                              color: Theme.of(context).primaryColor),
                        ),
                        IconButton(
                            splashRadius: 20,
                            onPressed: () {},
                            icon: Icon(Icons.mic,
                                color: Theme.of(context).primaryColor))
                        // IconButton(
                        //     onPressed: () {},
                        //     splashRadius: 20,
                        //     icon: Icon(Icons.send,
                        //         color: Theme.of(context).primaryColor))
                      ],
                    ),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    border: InputBorder.none),
              )),
        ));
  }
}
