import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:info_keeper/app/models/folder.dart';
import 'package:info_keeper/app/models/home/home_item.dart';
import 'package:info_keeper/generated/l10n.dart';

class HomeProvider extends ChangeNotifier {
  int _selectedItem = 0;
  int _selectedFolder = 0;

  final GlobalKey<ExpandableFabState> _fabKey = GlobalKey<ExpandableFabState>();
  final List<Folder> _folders = [
    Folder(title: S.current.main_screen_title, children: [])
  ];
  bool _menuIsOpen = false;

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

  bool get menuIsOpen => _menuIsOpen;
  set menuIsOpen(bool open) {
    _menuIsOpen = open;
    notifyListeners();
  }

  int get selectedFolder => _selectedFolder;
  set selectedFolder(int index) {
    _selectedFolder = index;
    notifyListeners();
  }

  int get selectedItem => _selectedItem;
  set selectedItem(int index) {
    _selectedItem = index;
    notifyListeners();
  }

  UnmodifiableListView<HomeItem> get all =>
      UnmodifiableListView(_folders[_selectedFolder].children);
  void addChild(dynamic child) {
    _folders[_selectedFolder].children.add(child);
    notifyListeners();
  }

  void setItemAnimation() {
    _folders[_selectedFolder].children[_selectedItem].values.setItAnimated();
    _menuIsOpen = false;
    notifyListeners();
  }
}
