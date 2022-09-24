import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/pages/favorites/favorites_page.dart';
import 'package:info_keeper/pages/home_page/items/chat/pages/media/media_page.dart';
import 'package:info_keeper/pages/home_page/items/chat/pages/search/search_title.dart';
import 'package:info_keeper/pages/home_page/items/chat/pages/titles/title_page.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/app_bar/bottom.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/body.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/btm_app_bar/btm_app_bar.dart';
import 'package:info_keeper/pages/home_page/items/widgets/app_bar/app_bar.dart';
import 'package:info_keeper/pages/home_page/items/widgets/app_bar/widgets/popup_menu.dart';
import 'package:info_keeper/pages/vault_page/vault_page.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:swipe/swipe.dart';

class ChatPage extends StatelessWidget {
  final HomeItem homeItem;
  const ChatPage({Key? key, required this.homeItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());
    final HomeController home = Get.find();
    Chat chat = homeItem.child;
    controller.homeItem = homeItem;
    RxList messages = chat.messages;
    controller.refreshPinnedMessages(messages);

    // title
    TextEditingController titleController =
        TextEditingController(text: homeItem.name);
    FocusNode titleFocus = FocusNode();

    // body
    final RxString pathToImage = chat.backgroundImage.obs;
    controller.autoScrollController = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).viewInsets.bottom),
        axis: Axis.vertical);

    List<PopupMenuItem> popupItems() {
      List<PopupMenuItem> items = [];

      PopupMenuItem search = PopupMenuItem(
          onTap: () => controller.isSearch.value = !controller.isSearch.value,
          child: const PopupMenuItemBody(title: 'Search', icon: Icons.search));

      PopupMenuItem rename = PopupMenuItem(
          onTap: () =>
              controller.changeTitle.value = !controller.changeTitle.value,
          child: const PopupMenuItemBody(
              title: 'Rename chat', icon: Icons.edit_outlined));

      PopupMenuItem media = const PopupMenuItem(
          value: 0,
          child: PopupMenuItemBody(title: 'Media', icon: Icons.cloud_outlined));

      PopupMenuItem date = PopupMenuItem(
          onTap: () => controller.showDate.value = !controller.showDate.value,
          child: const PopupMenuItemBody(
              title: 'Show date', icon: Icons.date_range_outlined));

      PopupMenuItem background = PopupMenuItem(
          onTap: () async {
            FilePickerResult? result =
                await FilePicker.platform.pickFiles(type: FileType.image);
            if (result != null) {
              pathToImage.value = result.files.single.path!;
              chat.copyWith(backgroundImage: pathToImage.value);
            }
          },
          child: const PopupMenuItemBody(
              title: 'Change background', icon: Icons.palette_outlined));

      items.addAll([search, rename, media, date, background]);

      return items;
    }

    List actions() {
      List actions = [];
      return actions;
    }

    return Swipe(
        onSwipeRight: () => Get.to(() => const VaultPage(isChat: true)),
        child: Obx(() => Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(
                    controller.pinnedMessages.isNotEmpty
                        ? 100
                        : kToolbarHeight),
                child: AppBarWidget(
                    title: !controller.changeTitle.value
                        ? controller.isSearch.value
                            ? ChatSearchTitle(messages: chat.messages)
                            : Text(titleController.text)
                        : null,
                    titleSpacing: controller.changeTitle.value ||
                            controller.isSearch.value
                        ? 0
                        : 20,
                    bottom: controller.pinnedMessages.isNotEmpty
                        ? const PreferredSize(
                            preferredSize: Size.fromHeight(double.infinity),
                            child: ChatAppBarBottomWidget())
                        : null,
                    controller: titleController,
                    change: controller.changeTitle,
                    leadingButtonFunc: () {
                      if (controller.isSearch.value) {
                        controller.isSearch.value = !controller.isSearch.value;
                        controller.searchItems.clear();
                        controller.searchController.clear();
                      } else if (home.isSearch.value) {
                        Get.back();
                      } else {
                        homeItem.copyWith(name: titleController.text);
                        Get.back();
                      }
                    },
                    actions: controller.isSearch.value
                        ? null
                        : [
                            IconButton(
                                splashRadius: 20,
                                onPressed: () =>
                                    Get.to(() => ChatTitlesPage(chat: chat)),
                                icon: const Icon(Icons.title)),
                            IconButton(
                                splashRadius: 20,
                                onPressed: () =>
                                    Get.to(() => ChatFavoritesPage(chat: chat)),
                                icon: const Icon(Icons.star_outline)),
                            PopupMenuButton(
                                splashRadius: 20,
                                onSelected: (value) => value == 0
                                    ? Get.to(
                                        () => ChatMediaPage(homeItem: homeItem))
                                    : null,
                                itemBuilder: (context) => popupItems())
                          ],
                    focus: titleFocus)),
            body: ChatBody(chat: homeItem.child, pathToImage: pathToImage),
            bottomNavigationBar: !controller.isSearch.value
                ? ChatBottomAppBar(homeItem: homeItem)
                : null)));
  }
}
