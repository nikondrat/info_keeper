import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';
import 'package:info_keeper/widgets/notifications.dart';

class HomeBottomMenu extends StatelessWidget {
  const HomeBottomMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final HomeController home = Get.find();
    late HomeItem item = Controller.to.all[Controller.to.selectedFolder.value]
        .childrens[Controller.to.selectedElementIndex.value];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            splashRadius: 20,
            onPressed: () {
              home.isShowBottomMenu.value = false;
            },
            icon: const Icon(Icons.close)),
        Row(
          children: [
            IconButton(
                splashRadius: 20,
                onPressed: () {
                  item.copyWith(isPinned: !item.isPinned);
                  home.isShowBottomMenu.value = false;
                },
                icon: const Icon(Icons.push_pin_outlined)),
            IconButton(
              splashRadius: 20,
              onPressed: () {
                item.copyWith(isAnimated: !item.isAnimated);
                home.isShowBottomMenu.value = false;
              },
              icon: const Icon(
                Icons.local_fire_department_outlined,
              ),
            ),
            Notifications(name: item.name, locElement: item.location),
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
