import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:info_keeper/app/models/home/home_item.dart';

class HomeProvider extends ChangeNotifier {
  final GlobalKey<ExpandableFabState> _fabKey = GlobalKey<ExpandableFabState>();
  final List<HomeItem> _children = [];

  GlobalKey<ExpandableFabState> get fabKey => _fabKey;
  void openCloseFab({bool close = false}) {
    final ExpandableFabState? state = _fabKey.currentState;
    if (state != null) {
      if (close) {
        state.isOpen ? state.toggle() : null;
      } else {
        state.toggle();
      }
    }
  }

  UnmodifiableListView<HomeItem> get all => UnmodifiableListView(_children);
  void addChild(dynamic child) {
    _children.add(child);
    notifyListeners();
  }

  void setItemAnimation(int index, bool isAnimated) {
    _children
        .firstWhere((element) => element.index == index)
        .values
        .setItAnimated(isAnimated);
    notifyListeners();
  }
}
