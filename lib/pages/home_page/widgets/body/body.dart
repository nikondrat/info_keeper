import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController home = Get.find();

    return Obx(
      () => MasonryGridView.count(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          crossAxisCount: home.isGridView.value ? 2 : 1,
          itemCount: Controller.to.all[Controller.to.selectedFolder.value]
              .getChildrens()
              .length,
          itemBuilder: (context, homeItemIndex) {
            return Padding(
                padding: const EdgeInsets.all(5),
                child: HomeBodyItem(
                    homeItem: Controller
                        .to.all[Controller.to.selectedFolder.value]
                        .getChildrens()[homeItemIndex],
                    homeItemIndex: homeItemIndex));
          }),
    );
  }
}
