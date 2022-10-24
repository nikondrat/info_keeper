import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';
import 'package:info_keeper/pages/home_page/items/widgets/app_bar/widgets/popup_menu.dart';
import 'package:info_keeper/pages/home_page/widgets/app_bar/search.dart';
import 'package:info_keeper/pages/trash_page/trash_page.dart';
import 'package:info_keeper/themes/default/default.dart';
import 'package:info_keeper/themes/default/default_dark.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController home = Get.find();
    List<PopupMenuItem> popupItems() {
      List<PopupMenuItem> items = [];

      PopupMenuItem search = PopupMenuItem(
          onTap: () => home.isSearch.value = !home.isSearch.value,
          child: const PopupMenuItemBody(title: 'Search', icon: Icons.search));

      PopupMenuItem trash = const PopupMenuItem(
          value: 1,
          child: PopupMenuItemBody(
              title: 'Trash bin', icon: Icons.delete_outline));

      items.addAll([search, trash]);

      return items;
    }

    return AppBar(
        titleSpacing: 0,
        leading: Obx(() => home.isSearch.value
            ? IconButton(
                splashRadius: 20,
                onPressed: () {
                  home.isSearch.value = !home.isSearch.value;
                  home.searchItems.clear();
                  home.searchController.clear();
                },
                icon: const Icon(Icons.arrow_back))
            : PopupMenuButton(
                splashRadius: 20,
                icon: const Icon(Icons.menu),
                onSelected: (value) =>
                    value == 1 ? Get.to(() => const TrashPage()) : null,
                itemBuilder: (context) => popupItems(),
              )),
        title: Obx(() => home.isSearch.value
            ? const HomePageSearch()
            : const AutoSizeText(
                'Info Keeper',
                style: TextStyle(fontSize: 18),
              )),
        actions: [
          ThemeSwitcher(
              builder: (context) => IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    ThemeSwitcher.of(context).changeTheme(
                      theme: !Controller.to.isDark ? defaultDark : defaultLight,
                      isReversed: Controller.to.isDark ? true : false,
                    );
                    Controller.to.isDark = !Controller.to.isDark;
                    Controller.to.setData();
                  },
                  icon: Icon(Controller.to.isDark
                      ? Icons.light_mode
                      : Icons.dark_mode))),
          IconButton(
              splashRadius: 20,
              onPressed: () => home.isGridView.value = !home.isGridView.value,
              icon: Obx(() => Icon(
                  home.isGridView.value ? Icons.list : Icons.grid_view,
                  size: 28)))
        ]);
  }
}
