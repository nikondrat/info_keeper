import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:info_keeper/app/models/home/chat.dart';
import 'package:info_keeper/app/models/home/home_item.dart';
import 'package:info_keeper/app/providers/home_provider.dart';
import 'package:info_keeper/app/values/values.dart';
import 'package:info_keeper/app/widgets/home/home_item.dart';
import 'package:info_keeper/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:swipe/swipe.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
        child: Swipe(
            onSwipeRight: () {},
            child: GestureDetector(
              onTap: () =>
                  context.read<HomeProvider>().openCloseFab(close: true),
              child: Scaffold(
                  appBar: AppBar(
                    title: Text(S.of(context).app_name),
                  ),
                  body: const _Body(),
                  floatingActionButtonLocation: ExpandableFab.location,
                  floatingActionButton: _ExpandableFab()),
            )));
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      padding: const EdgeInsets.all(kDefaultPadding),
      physics: const BouncingScrollPhysics(),
      itemCount: context.watch<HomeProvider>().all.length,
      crossAxisCount: 2,
      itemBuilder: (context, index) =>
          HomeItemWidget(homeItem: context.watch<HomeProvider>().all[index]),
    );
  }
}

class _ExpandableFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeProvider model = Provider.of<HomeProvider>(context);

    return ExpandableFab(
      key: model.fabKey,
      children: [
        FloatingActionButton.small(
          heroTag: null,
          child: const Icon(Icons.keyboard_voice_outlined),
          onPressed: () {
            model.openCloseFab();
            // AudioPage

            // Navigator.push(context,
            //     CupertinoPageRoute(builder: (context) => LicensePage()));
          },
        ),
        FloatingActionButton.small(
          heroTag: null,
          child: const Icon(Icons.add_task),
          onPressed: () {
            model.openCloseFab();
            // TaskPage
          },
        ),
        FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.file_open_outlined),
            onPressed: () {
              model.openCloseFab();
              // StorageFilePage
            }),
        FloatingActionButton.small(
          heroTag: null,
          child: const Icon(Icons.chat_bubble_outline),
          onPressed: () {
            // HomeAlertDialog
            model.openCloseFab();
            showDialog(
                context: context, builder: (context) => const _ChatDialog());
          },
        ),
      ],
    );
  }
}

class _ChatDialog extends StatelessWidget {
  const _ChatDialog();

  @override
  Widget build(BuildContext context) {
    final HomeProvider model =
        Provider.of<HomeProvider>(context, listen: false);
    final TextEditingController textEditingController = TextEditingController();

    return AlertDialog(
      title: Text(S.of(context).add_chat_title),
      content: TextField(
          autofocus: true,
          maxLength: 18,
          controller: textEditingController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
          onSubmitted: (value) {
            if (textEditingController.text.isNotEmpty) {
              model.addChild(HomeItem(
                  index: model.all.length,
                  title: textEditingController.text,
                  child: Chat(children: []),
                  values: HomeItemValues()));
              Navigator.pop(context);
            }
          }),
      actions: [
        TextButton(
            child: Text(S.of(context).create),
            onPressed: () {
              if (textEditingController.text.isNotEmpty) {
                model.addChild(HomeItem(
                    index: model.all.length,
                    title: textEditingController.text,
                    child: Chat(children: []),
                    values: HomeItemValues()));
                Navigator.pop(context);
              }
            }),
        TextButton(
            child: Text(S.of(context).cancel,
                style: const TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
    );
  }
}
