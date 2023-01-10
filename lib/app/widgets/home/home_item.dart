import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:info_keeper/app/models/home/home_item.dart';
import 'package:info_keeper/app/models/home/home_type.dart';
import 'package:info_keeper/app/providers/home_provider.dart';
import 'package:info_keeper/app/values/values.dart';
import 'package:info_keeper/app/views/chat_view.dart';
import 'package:provider/provider.dart';

class HomeItemWidget extends StatelessWidget {
  final HomeItem homeItem;
  const HomeItemWidget({super.key, required this.homeItem});

  @override
  Widget build(BuildContext context) {
    return _Gesture(
      homeItem: homeItem,
      child: homeItem.values.isAnimated
          ? _Animation(child: _Decoration(homeItem: homeItem))
          : _Decoration(homeItem: homeItem),
    );
  }
}

class _Gesture extends StatelessWidget {
  final Widget child;
  final HomeItem homeItem;
  const _Gesture({required this.child, required this.homeItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<HomeProvider>(context, listen: false)
            .openCloseFab(close: true);

        switch (homeItem.child.type) {
          case HomeItemType.chat:
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => ChatView(homeItem: homeItem)));
            break;
          case HomeItemType.storageFile:
          case HomeItemType.task:
          case HomeItemType.audioNote:
          default:
        }
      },
      child: child,
    );
  }
}

class _Decoration extends StatelessWidget {
  final HomeItem homeItem;
  const _Decoration({required this.homeItem});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultRadius),
            border: Border.all(
                color: homeItem.values.isAnimated
                    ? const Color(0xFFB9DFBB)
                    : Colors.grey.shade600,
                width: 1)),
        child: Text(homeItem.title));
  }
}

class _Animation extends StatelessWidget {
  final Widget child;
  const _Animation({required this.child});

  @override
  Widget build(BuildContext context) {
    return Animate(
        effects: const [
          ShimmerEffect(
              delay: Duration(milliseconds: 1),
              color: Colors.red,
              size: 1,
              duration: Duration(seconds: 1))
        ],
        onComplete: (controller) => controller.dispose(),
        onInit: (controller) => controller.repeat(),
        child: child);
  }
}
