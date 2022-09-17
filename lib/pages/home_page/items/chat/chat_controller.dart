import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ChatController extends GetxController {
  late HomeItem homeItem;
  // search
  final TextEditingController searchController = TextEditingController();
  final RxList searchItems = [].obs;

  // title
  final RxBool changeTitle = false.obs;
  final RxBool isSearch = false.obs;

  // body
  final RxBool showDate = false.obs;
  late AutoScrollController autoScrollController;

  // bottom

  //  = AutoScrollController(
  //    viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, 1),
  //   axis: Axis.vertical,
  // );
}
