import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  // search
  final TextEditingController searchController = TextEditingController();
  final RxList searchItems = [].obs;

  // title
  final RxBool changeTitle = false.obs;
  final RxBool isSearch = false.obs;

  // body
  final RxBool showDate = false.obs;
}
