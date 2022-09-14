import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomAppBarController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  final RxBool textFieldIsEmpty = true.obs;
  final RxBool isShowTitleTextField = false.obs;
  final RxBool isShowColorSelector = false.obs;
}
