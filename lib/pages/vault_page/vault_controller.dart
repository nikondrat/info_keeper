import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VaultController extends GetxController {
  RxBool isUnblocked = false.obs;
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
}
