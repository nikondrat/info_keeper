import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/themes/theme_controller.dart';

class BodyWithTheme extends StatelessWidget {
  final Widget body;
  final String pathToImage;
  const BodyWithTheme({super.key, required this.body, this.pathToImage = ''});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());
    final bool brightness =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    themeController.isDark = brightness.obs;

    DecorationImage? imageWidget = pathToImage.isNotEmpty
        ? DecorationImage(
            image: FileImage(File(pathToImage)), fit: BoxFit.cover)
        : null;

    Widget blackBody = Container(
        decoration: BoxDecoration(
            image: imageWidget,
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF2E3134), Color(0xFF232527)])),
        child: body);

    return Obx(() => themeController.isDark.value ? blackBody : body);
  }
}
