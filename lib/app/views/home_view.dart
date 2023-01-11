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
                  bottomNavigationBar: const _BottomBar(),
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

class _BottomBar extends StatelessWidget {
  const _BottomBar();

  @override
  Widget build(BuildContext context) {
    HomeProvider model = Provider.of(context);
    bool isMainFolder = model.selectedFolder == 0;

    Row menu = Row(children: [
      IconButton(
          splashRadius: 20,
          onPressed: () {
            model.menuIsOpen = false;
          },
          icon: const Icon(Icons.close)),
      Row(children: [
        IconButton(
            splashRadius: 20,
            onPressed: () {},
            icon: const Icon(Icons.push_pin_outlined)),
        IconButton(
          splashRadius: 20,
          onPressed: () => model.setItemAnimation(),
          icon: const Icon(
            Icons.local_fire_department_outlined,
          ),
        ),
        IconButton(
            splashRadius: 20,
            onPressed: () {},
            icon: const Icon(Icons.lock_outline))
      ])
    ]);

    return BottomAppBar(
      child: model.menuIsOpen
          ? menu
          : Row(
              mainAxisAlignment: isMainFolder
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                isMainFolder
                    ? const SizedBox.shrink()
                    : IconButton(
                        onPressed: () {},
                        splashRadius: 20,
                        icon: const Icon(Icons.home_outlined)),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(kDefaultRadius * 3))),
                          builder: (context) => const _Folders());
                    },
                    splashRadius: 20,
                    icon: const Icon(Icons.folder_copy_outlined)),
                isMainFolder
                    ? const SizedBox.shrink()
                    : const SizedBox(width: 50)
              ],
            ),
    );
  }
}

class _Folders extends StatelessWidget {
  const _Folders();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
            // Get.to(() => const AddFolderPage());
          },
          icon: const Icon(
            Icons.add,
          ),
          splashRadius: 20,
        ),
        const Icon(
          Icons.folder_copy_outlined,
        ),
        IconButton(
          icon: const Icon(Icons.close),
          splashRadius: 20,
          onPressed: () => Navigator.pop(context),
        )
      ]),
      Expanded(
          child: GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: context.watch<HomeProvider>().all.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: MediaQuery.of(context).size.height * 0.0022,
                  maxCrossAxisExtent: 200,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8),
              itemBuilder: (context, index) => Text(
                    context.watch<HomeProvider>().all[index].title,
                  )))
    ]);
  }
}

class _ExpandableFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeProvider model = Provider.of<HomeProvider>(context);

    return ExpandableFab(
      key: model.fabKey,
      distance: 70,
      fanAngle: 120,
      child: const Icon(Icons.add),
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
