import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home_item.dart';

class HomeController extends GetxController {
  late AnimationController controller;
  // search
  final RxBool isSearch = false.obs;
  TextEditingController searchController = TextEditingController();
  RxList<HomeItem> searchItems = <HomeItem>[].obs;

  final RxBool isGridView = true.obs;

  final RxBool isShowDialMenu = false.obs;
  final RxBool isShowBottomMenu = false.obs;

  void toggle() {
    isShowDialMenu.value = !isShowDialMenu.value;
    if (isShowDialMenu.value) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }
}
