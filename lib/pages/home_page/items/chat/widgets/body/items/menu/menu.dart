import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/model/types/trash/trash_item.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/pages/history/history_page.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/menu/item.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/message/widgets/in_fullscreen.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/btm_app_bar/btm_app_bar_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/btm_app_bar/widgets/color_selector/color_selector.dart';
import 'package:info_keeper/pages/vault_page/vault_page.dart';
import 'package:info_keeper/widgets/notifications.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MessageMenuWidget extends StatelessWidget {
  final Message message;
  const MessageMenuWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final BottomAppBarController barController =
        Get.put(BottomAppBarController());
    final ChatController chatController = Get.find();

    final Chat chat = chatController.homeItem.child;
    RxList messages = chat.messages;

    List<Widget> children() {
      List<Widget> children = [];

      MenuItemWidget copy = MenuItemWidget(
          title: 'Copy',
          icon: const Icon(Icons.copy),
          onPressed: () {
            Navigator.pop(context);
            Clipboard.setData(ClipboardData(text: message.content));
            Get.snackbar('Done', 'The message has been copied',
                shouldIconPulse: true,
                icon: const Icon(Icons.done),
                margin: const EdgeInsets.all(10),
                duration: const Duration(seconds: 1),
                isDismissible: true,
                snackPosition: SnackPosition.BOTTOM);
          });

      MenuItemWidget edit = MenuItemWidget(
          title: 'Edit',
          icon: const Icon(Icons.edit_outlined),
          onPressed: () {
            barController.isEditMessage.value = true;
            barController.messageController.value =
                TextEditingValue(text: message.content);
            barController.titleController.value =
                TextEditingValue(text: message.title);
            barController.editMessageText.value = message.content;
            // barController.textFieldIsEmpty.value = false;
            Navigator.pop(context);
          });

      MenuItemWidget highlite = MenuItemWidget(
          title: 'Highlite',
          icon: const Icon(Icons.brush_outlined),
          onPressed: () {
            Navigator.pop(context);
            showBarModalBottomSheet(
                context: context,
                elevation: 0,
                builder: (context) => ChatBottomAppBarColorSelector(
                    chat: chat, message: message));
          });

      MenuItemWidget history = MenuItemWidget(
          title: 'Edit history',
          icon: const Icon(Icons.history),
          onPressed: () {
            Navigator.pop(context);
            Get.to(() => ChatMessageHistoryPage(history: message.history!));
          });

      MenuItemWidget unite = MenuItemWidget(
          title: 'Unite messages',
          icon: const Icon(Icons.forum_outlined),
          onPressed: () {
            chatController.uniteMessage.value = true;
            message.isSelected = !message.isSelected;
            messages[messages.indexOf(message)] = message;
            chat.copyWith(messages: messages);
            Navigator.pop(context);
          });

      MenuItemWidget move = MenuItemWidget(
          title: 'Move message',
          icon: const Icon(Icons.drag_handle),
          onPressed: () {
            chatController.moveMessage.value = true;
            message.isSelected = !message.isSelected;
            messages[messages.indexOf(message)] = message;
            chatController.secondSelectedMessage = message;
            chat.copyWith(messages: messages);
            Navigator.pop(context);
          });

      MenuItemWidget inFull = MenuItemWidget(
          title: 'Full screen',
          icon: const Icon(Icons.open_in_full),
          onPressed: () {
            Navigator.pop(context);
            context.pushTransparentRoute(
                MessageWidgetInFullScreen(message: message));
          });

      MenuItemWidget pin = MenuItemWidget(
          title: message.isPinned ? 'Unpin' : 'Pin',
          icon: const Icon(Icons.push_pin_outlined),
          onPressed: () {
            message.isPinned = !message.isPinned;
            messages[messages.indexOf(message)] = message;
            chat.copyWith(messages: messages);
            Navigator.pop(context);
          });

      MenuItemWidget favorites = MenuItemWidget(
          title:
              message.isFavorite ? 'Remove from favorites' : 'Add to favorites',
          icon: const Icon(Icons.star_outline),
          onPressed: () {
            message.isFavorite = !message.isFavorite;
            messages[messages.indexOf(message)] = message;
            chat.copyWith(messages: messages);
            Navigator.pop(context);
          });

      MenuItemWidget lock = MenuItemWidget(
          title: message.isLocked ? 'Unlock' : 'Lock message',
          icon: const Icon(Icons.lock_outline),
          onPressed: () {
            Navigator.pop(context);
            Get.to(() => VaultPage(isChat: true, item: message));
            // message.isLocked = !message.isLocked;
            // message.isUnlocked = false;
            // messages[messages.indexOf(message)] = message;
            // chat.copyWith(messages: messages);
          });

      var notifications = Notifications(
        isChat: true,
        homeItem: chatController.homeItem,
      );

      MenuItemWidget trash = MenuItemWidget(
          title: 'Move to trash',
          icon: const Icon(Icons.delete),
          onPressed: () {
            Controller.to.trashElements
                .add(TrashItem(child: message, isMessage: true));
            messages.removeAt(messages.indexOf(message));
            Navigator.pop(context);
          });

      if (chatController.isVault.value) {
        children.addAll([copy, highlite, history, inFull, lock, trash]);
      } else if (chatController.isPinnedMessagesPage.value) {
        children.addAll([copy, highlite, history, inFull, pin]);
      } else if (chatController.isTitlesPage.value) {
        children.addAll([copy, history, inFull, pin]);
      } else if (chatController.isFavoritesPage.value) {
        children.addAll([copy, history, inFull, pin, favorites]);
      } else {
        children.addAll([
          copy,
          edit,
          highlite,
          history,
          unite,
          move,
          inFull,
          pin,
          favorites,
          lock,
          notifications,
          trash
        ]);
      }

      return children;
    }

    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            children: children()));
  }
}
