import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item.dart';

class HomePageSearchBody extends StatelessWidget {
  const HomePageSearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController home = Get.find();
    return Obx(() => ListView.builder(
        itemCount: home.searchItems.length,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemBuilder: (context, index) => HomeBodyItem(
            homeItem: home.searchItems[index], homeItemIndex: index)));
  }
}
