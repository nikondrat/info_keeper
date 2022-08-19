import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body.dart';
import 'package:info_keeper/pages/home_page/widgets/btm_bar/btm_bar.dart';
import 'package:info_keeper/pages/home_page/widgets/fab_menu/float_btns.dart';
import 'package:info_keeper/pages/home_page/home_search.dart';
import 'package:info_keeper/pages/trash_page/trash_page.dart';
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
              childrens: Controller
                  .to.all[Controller.to.selectedFolder.value].childrens,
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
                icon: Obx(() => Icon(
                      isGridView.value ? Icons.list : Icons.grid_view,
                      size: 26,
                    )),
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
                if (value == 1) {
                  Get.to(() => const TrashPage());
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
          body: HomeBody(isGridView: isGridView),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: const HomeFloatButtons(),
          bottomNavigationBar: const HomeBottomBar()),
    );
  }
}
