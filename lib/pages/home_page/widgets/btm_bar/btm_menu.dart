import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/location_element.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';
import 'package:info_keeper/widgets/notifications.dart';

class HomeBottomMenu extends StatelessWidget {
  const HomeBottomMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final HomeController home = Get.find();
    late final item = Controller.to.all[Controller.to.selectedFolder.value]
        .childrens[Controller.to.selectedElementIndex.value];

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
                  home.pinItem(item);
                  home.isShowBottomMenu.value = false;
                },
                icon: const Icon(Icons.push_pin_outlined)),
            IconButton(
              splashRadius: 20,
              onPressed: () {
                // animate();
                home.isShowBottomMenu.value = false;
              },
              icon: const Icon(
                Icons.local_fire_department_outlined,
              ),
            ),
            Notifications(
              name: Controller.to.all[Controller.to.selectedFolder.value]
                  .childrens[Controller.to.selectedElementIndex.value].name,
              locElement: LocationElement(
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
