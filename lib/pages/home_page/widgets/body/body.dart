import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController home = Get.put(HomeController());
    RxList<HomeItem> childrens =
        Controller.to.all[Controller.to.selectedFolder.value].childrens;

    Widget body = Obx(() => MasonryGridView.count(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        crossAxisCount: home.isGridView.value ? 2 : 1,
        itemCount: home.isSearch.value
            ? home.searchItems.length
            : Controller
                .to.all[Controller.to.selectedFolder.value].childrens.length,
        itemBuilder: (context, homeItemIndex) => Padding(
            padding: childrens[homeItemIndex].isLocked
                ? EdgeInsets.zero
                : const EdgeInsets.all(5),
            child: Obx(
              () => childrens[homeItemIndex].isLocked
                  ? const SizedBox()
                  : HomeBodyItem(
                      homeItem: home.isSearch.value
                          ? home.searchItems[homeItemIndex]
                          : childrens[homeItemIndex],
                      homeItemIndex: homeItemIndex),
            ))));

    return body;
  }
}
