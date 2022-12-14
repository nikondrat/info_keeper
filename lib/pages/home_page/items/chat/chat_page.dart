import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/chat_type.dart';
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
    controller.isFavoritesPage.value = false;
    controller.isTitlesPage.value = false;
    controller.isPinnedMessagesPage.value = false;
    controller.isVault.value = false;
    final HomeController home = Get.find();

    Chat chat = homeItem.child;
    controller.homeItem = homeItem;
    RxList messages = chat.messages;

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

    uniteMessages() {
      List<Message> selectedMessages = [];

      for (int i = 0; i < messages.length; i++) {
        if (messages[i].type == ChatType.message &&
            messages[i].isSelected &&
            !messages[i].isLocked) {
          selectedMessages.add(messages[i]);
        }
      }
      StringBuffer stringBuffer = StringBuffer();

      for (Message message in selectedMessages.reversed) {
        stringBuffer.writeln(message.content);
      }
      messages[selectedMessages.last.location.itemIndex!].content =
          stringBuffer.toString();
      messages[selectedMessages.last.location.itemIndex!].isSelected = false;
      selectedMessages.removeLast();

      for (int i = 0; i < selectedMessages.length; i++) {
        messages.removeAt(messages.indexOf(selectedMessages[i]));
      }
      chat.copyWith(messages: messages);
      controller.uniteMessage.value = false;
    }

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

    RxList<Widget> actions() {
      RxList<Widget> actions = <Widget>[].obs;

      Widget titleButton = IconButton(
          splashRadius: 20,
          onPressed: () {
            controller.isTitlesPage.value = true;
            Get.to(() => ChatTitlesPage(chat: chat));
          },
          icon: const Icon(Icons.title));

      Widget favoritesButton = IconButton(
          splashRadius: 20,
          onPressed: () {
            controller.isFavoritesPage.value = true;
            Get.to(() => ChatFavoritesPage(chat: chat));
          },
          icon: const Icon(Icons.star_outline));

      Widget popupsButton = PopupMenuButton(
          splashRadius: 20,
          onSelected: (value) => value == 0
              ? Get.to(() => ChatMediaPage(homeItem: homeItem))
              : null,
          itemBuilder: (context) => popupItems());

      Widget uniteButton = IconButton(
          splashRadius: 20,
          onPressed: uniteMessages,
          icon: const Icon(Icons.done));

      if (controller.uniteMessage.value) {
        actions.add(uniteButton);
      } else {
        actions.addAll([titleButton, favoritesButton, popupsButton]);
      }

      return actions;
    }

    return Swipe(
        onSwipeRight: () {
          ChatController chatController = Get.find();
          chatController.isVault.value = true;
          Get.to(() => const VaultPage(isChat: true));
        },
        child: ThemeSwitchingArea(
            child: Obx(() => Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: PreferredSize(
                    preferredSize: Size.fromHeight(
                        controller.pinnedMessages(messages).isNotEmpty
                            ? 100
                            : kToolbarHeight),
                    child: AppBarWidget(
                        homeItem: homeItem,
                        title: !controller.changeTitle.value
                            ? controller.isSearch.value
                                ? ChatSearchTitle(messages: chat.messages)
                                : Text(titleController.text)
                            : null,
                        titleSpacing: controller.changeTitle.value ||
                                controller.isSearch.value
                            ? 0
                            : 20,
                        bottom: controller.pinnedMessages(messages).isNotEmpty
                            ? PreferredSize(
                                preferredSize:
                                    const Size.fromHeight(double.infinity),
                                child:
                                    ChatAppBarBottomWidget(messages: messages))
                            : null,
                        controller: titleController,
                        change: controller.changeTitle,
                        leadingButtonFunc: () {
                          if (controller.isSearch.value) {
                            controller.isSearch.value =
                                !controller.isSearch.value;
                            controller.searchItems.clear();
                            controller.searchController.clear();
                          } else if (controller.uniteMessage.value) {
                            controller.uniteMessage.value = false;
                          } else if (home.isSearch.value) {
                            Get.back();
                          } else if (controller.changeTitle.value) {
                            homeItem.copyWith(name: titleController.text);
                          } else {
                            Get.back();
                          }
                        },
                        actions: actions(),
                        focus: titleFocus)),
                body: ChatBody(chat: homeItem.child, pathToImage: pathToImage),
                bottomNavigationBar: !controller.isSearch.value
                    ? ChatBottomAppBar(homeItem: homeItem)
                    : null))));
  }
}
