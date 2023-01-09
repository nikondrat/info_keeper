import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:info_keeper/app/models/home_item.dart';
import 'package:info_keeper/app/values/values.dart';
import 'package:info_keeper/app/widgets/home/home_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ExpandableFabState> fabKey =
        GlobalKey<ExpandableFabState>();

    void closeFab() {
      final state = fabKey.currentState;
      if (state != null) {
        if (state.isOpen) {
          return state.toggle();
        }
      }
    }

    return GestureDetector(
      onTap: () => closeFab(),
      child: Scaffold(
          appBar: AppBar(
            title: Text('hello'),
          ),
          body: _Body(),
          floatingActionButtonLocation: ExpandableFab.location,
          floatingActionButton: _ExpandableFab(fabKey: fabKey)),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
        padding: const EdgeInsets.all(kDefaultPadding),
        physics: const BouncingScrollPhysics(),
        itemCount: 1,
        crossAxisCount: 2,
        itemBuilder: (context, index) =>
            HomeItemWidget(homeItem: HomeItem(title: 'Hello')));
  }
}

class _ExpandableFab extends StatelessWidget {
  final GlobalKey<ExpandableFabState> fabKey;
  const _ExpandableFab({required this.fabKey});

  @override
  Widget build(BuildContext context) {
    void closeFab() {
      final state = fabKey.currentState;
      if (state != null) {
        return state.toggle();
      }
    }

    return ExpandableFab(
      key: fabKey,
      children: [
        FloatingActionButton.small(
          heroTag: null,
          child: const Icon(Icons.keyboard_voice_outlined),
          onPressed: () {
            // AudioPage

            // Navigator.push(context,
            //     CupertinoPageRoute(builder: (context) => LicensePage()));
            closeFab();
          },
        ),
        FloatingActionButton.small(
          heroTag: null,
          child: const Icon(Icons.add_task),
          onPressed: () {
            // TaskPage
            closeFab();
          },
        ),
        FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.file_open_outlined),
            onPressed: () {
              // StorageFilePage
              closeFab();
            }),
        FloatingActionButton.small(
          heroTag: null,
          child: const Icon(Icons.chat_bubble_outline),
          onPressed: () {
            // HomeAlertDialog
            closeFab();
          },
        ),
      ],
    );
  }
}
