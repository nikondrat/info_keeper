import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/pages/home_page/widgets/app_bar/app_bar.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body.dart';
import 'package:info_keeper/pages/home_page/widgets/btm_bar/btm_bar.dart';
import 'package:info_keeper/pages/home_page/widgets/fab_menu/float_btns.dart';
import 'package:info_keeper/pages/vault_page/vault_page.dart';
import 'package:swipe/swipe.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swipe(
      onSwipeRight: () {
        Get.to(() => VaultPage(
              childrens: Controller
                  .to.all[Controller.to.selectedFolder.value].childrens,
              selectedElement: 0.obs,
            ));
      },
      child: const Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: HomeAppBar()),
          body: HomeBody(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: HomeFloatButtons(),
          bottomNavigationBar: HomeBottomBar()),
    );
  }
}
