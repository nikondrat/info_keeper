import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';
import 'package:info_keeper/pages/home_page/widgets/app_bar/app_bar.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body.dart';
import 'package:info_keeper/pages/home_page/widgets/body/search_body.dart';
import 'package:info_keeper/pages/home_page/widgets/btm_bar/btm_bar.dart';
import 'package:info_keeper/pages/home_page/widgets/fab_menu/float_btns.dart';
import 'package:info_keeper/pages/vault_page/vault_page.dart';
import 'package:swipe/swipe.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController home = Get.put(HomeController());

    return Swipe(
      onSwipeRight: () {
        Get.to(() => VaultPage(
              childrens: Controller
                  .to.all[Controller.to.selectedFolder.value].childrens,
              selectedElement: 0.obs,
            ));
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: HomeAppBar()),
          body: Obx(() => home.isSearch.value
              ? const HomePageSearchBody()
              : const HomeBody()),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: const HomeFloatButtons(),
          bottomNavigationBar: const HomeBottomBar()),
    );
  }
}
