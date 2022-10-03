import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';
import 'package:info_keeper/pages/home_page/widgets/btm_bar/btm_menu.dart';
import 'package:info_keeper/pages/home_page/widgets/btm_bar/btm_nav_bar.dart';

class HomeBottomBar extends StatelessWidget {
  final bool isVault;
  const HomeBottomBar({Key? key, this.isVault = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final HomeController home = Get.put(HomeController());

    return BottomAppBar(
      child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: Platform.isAndroid || Platform.isIOS ? 0.6 : 0.8,
                color: Platform.isAndroid || Platform.isIOS
                    ? Colors.grey
                    : Colors.black54,
              ),
            ),
          ),
          child: Obx(() => home.isShowBottomMenu.value
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HomeBottomMenu(isVault: isVault),
                    isVault ? const SizedBox() : const HomeBottomNavigation(),
                  ],
                )
              : isVault
                  ? const SizedBox()
                  : const HomeBottomNavigation())),
    );
  }
}
