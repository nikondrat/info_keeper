import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/pages/home_page/widgets/home_body.dart';
import 'package:info_keeper/pages/home_page/widgets/home_btm_nav_bar.dart';
import 'package:info_keeper/pages/home_page/widgets/home_float_btn.dart';
import 'package:info_keeper/pages/home_page/home_search.dart';
import 'package:info_keeper/pages/vault_page/vault_page.dart';
import 'package:swipe/swipe.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isGridView = true.obs;

    return Swipe(
      onSwipeRight: () {
        Get.to(() => VaultPage(
              childrens: Controller.to.all[Controller.to.selectedFolder.value]
                  .directoryChildrens,
              selectedElement: 0.obs,
            ));
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  isGridView.value = !isGridView.value;
                },
                icon: Obx(() =>
                    Icon(isGridView.value ? Icons.list : Icons.grid_view)),
                splashRadius: 20,
              ),
            ],
            leading: PopupMenuButton(
              icon: const Icon(Icons.menu),
              splashRadius: 20,
              onSelected: (value) {
                if (value == 0) {
                  Get.to(() => const SearchPage());
                }
              },
              padding: EdgeInsets.zero,
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 0,
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(Icons.search),
                      ),
                      Text('Search')
                    ],
                  ),
                ),
                // PopupMenuItem(
                //     child: Row(
                //   children: const [
                //     Padding(
                //       padding: EdgeInsets.only(right: 8),
                //       child: Icon(Icons.settings_outlined),
                //     ),
                //     Text('Settings')
                //   ],
                // )),
                PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(Icons.delete_outline),
                        ),
                        Text('Trash bin')
                      ],
                    )),
              ],
            ),
            title: const Text('Info Keeper'),
          ),
          body: HomePageBody(isGridView: isGridView),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: const HomePageFloatButton(),
          bottomNavigationBar: const HomePageBottomNavigationBar()),
    );
  }
}
