import 'dart:collection';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  List _children = [];
  UnmodifiableListView get all => UnmodifiableListView(_children);
  set children(List children) {
    _children = children;
  }

  void addChild(dynamic child) {
    _children.add(child);
    notifyListeners();
  }
}
