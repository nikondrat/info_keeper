import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/themes/default/default.dart';

class BottomAppBarController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  final RxBool textFieldIsEmpty = true.obs;
  final RxBool isShowTitleTextField = false.obs;
  final RxBool isEditMessage = false.obs;

  final RxInt selectedColor = defaultColor.obs;
  final RxString editMessageText = ''.obs;
}
