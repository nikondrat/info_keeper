import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/item_location.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';
import 'package:info_keeper/pages/home_page/widgets/folders/folders.dart';
import 'package:info_keeper/pages/home_page/items/widgets/app_bar/widgets/popup_menu.dart';
import 'package:info_keeper/widgets/notifications.dart';

class HomeBottomMenu extends StatelessWidget {
  const HomeBottomMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final HomeController home = Get.find();
    final List childrens =
        Controller.to.all[Controller.to.selectedFolder.value].childrens;
    final HomeItem item = childrens[Controller.to.selectedElementIndex.value];

    List<PopupMenuItem> popupItems() {
      List<PopupMenuItem> items = [];

      PopupMenuItem folder = PopupMenuItem(
          value: 0,
          onTap: () => home.isShowBottomMenu.value = false,
          child: const PopupMenuItemBody(
              title: 'Add to folder', icon: Icons.folder_copy_outlined));

      PopupMenuItem dublicate = PopupMenuItem(
          onTap: () {
            HomeItem dublicatedItem = item.copyWith(
                isDublicated: true,
                location: ItemLocation(
                    inDirectory: Controller.to.selectedFolder.value,
                    index: Controller.to.selectedElementIndex.value));

            Controller.to.all[Controller.to.selectedFolder.value].childrens
                .add(dublicatedItem);

            // dublicatedItem.location.index = Controller
            //     .to.all[Controller.to.selectedFolder.value].childrens.length;
            // dublicatedItem.isDublicated = true;

            // Controller.to.all[Controller.to.selectedFolder.value].childrens
            //     .add(dublicatedItem);
            // Controller.to.selectedElementIndex =
            //     dublicatedItem.location.index.obs;
          },
          child: const PopupMenuItemBody(
              title: 'Dublicate', icon: Icons.content_copy));

      PopupMenuItem delete = PopupMenuItem(
          onTap: () {
            Controller.to.all[Controller.to.selectedFolder.value].childrens
                .remove(item);
            Controller.to.setData();
            home.isShowBottomMenu.value = false;
          },
          child: const PopupMenuItemBody(
              title: 'Move to trash', icon: Icons.delete_outline));

      items.addAll([folder, dublicate, delete]);

      return items;
    }

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
                  Controller
                      .to.all[Controller.to.selectedFolder.value].childrens
                      .sort((a, b) => a.isPinned ? 0 : 1);

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
            Notifications(homeItem: item),
            IconButton(
                splashRadius: 20,
                onPressed: () {
                  home.isShowBottomMenu.value = false;
                  // lock();
                },
                icon: const Icon(Icons.lock_outline)),
            PopupMenuButton(
                splashRadius: 20,
                onSelected: (value) => value == 0
                    ? showModalBottomSheet(
                        context: context,
                        builder: (context) => const HomeFolders(isSelect: true))
                    : null,
                offset: const Offset(0, -170),
                itemBuilder: (context) => popupItems())
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
