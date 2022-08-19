import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/item_location.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';
import 'package:info_keeper/pages/home_page/widgets/btm_bar/btm_menu_controller.dart';
import 'package:info_keeper/widgets/notifications.dart';

class HomeBottomMenu extends StatefulWidget {
  const HomeBottomMenu({Key? key}) : super(key: key);

  @override
  State<HomeBottomMenu> createState() => _HomeBottomMenuState();
}

class _HomeBottomMenuState extends State<HomeBottomMenu> {
  late final HomeController home;
  late final BottomMenuController menu;
  late HomeItem item = Controller.to.all[Controller.to.selectedFolder.value]
      .childrens[Controller.to.selectedElementIndex.value];

  @override
  void initState() {
    home = Get.find();
    menu = Get.put(BottomMenuController());
    super.initState();
  }

  @override
  void dispose() {
    home.dispose();
    menu.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            splashRadius: 20,
            onPressed: () => home.isShowBottomMenu.value = false,
            icon: const Icon(Icons.close)),
        Row(
          children: [
            IconButton(
                splashRadius: 20,
                onPressed: () {
                  menu.pinItem(item);
                  home.isShowBottomMenu.value = false;
                },
                icon: const Icon(Icons.push_pin_outlined)),
            IconButton(
              splashRadius: 20,
              onPressed: () {
                menu.animateItem(item);
                home.isShowBottomMenu.value = false;
              },
              icon: const Icon(
                Icons.local_fire_department_outlined,
              ),
            ),
            Notifications(
              name: Controller.to.all[Controller.to.selectedFolder.value]
                  .childrens[Controller.to.selectedElementIndex.value].name,
              locElement: ItemLocation(
                  inDirectory: Controller.to.selectedFolder.value,
                  index: Controller.to.selectedElementIndex.value),
            ),
            IconButton(
                splashRadius: 20,
                onPressed: () {
                  home.isShowBottomMenu.value = false;
                  // lock();
                },
                icon: const Icon(Icons.lock_outline)),
            // PopupMenuButton(
            //     splashRadius: 20,
            //     onSelected: (value) {},
            //     offset: Offset(0, isVault ? -120 : -170),
            //     itemBuilder: (context) =>
            //         isVault ? vaultItems(context) : popupItems(context))
          ],
        ),
      ],
    );
  }
}
