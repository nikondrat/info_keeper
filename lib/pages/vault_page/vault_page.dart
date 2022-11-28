import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/folder.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/message/message.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item.dart';
import 'package:info_keeper/pages/home_page/widgets/btm_bar/btm_bar.dart';
import 'package:info_keeper/pages/vault_page/vault_controller.dart';
import 'package:info_keeper/pages/vault_page/vault_password.dart';

class VaultPage extends StatelessWidget {
  final bool isChat;
  final dynamic item;

  const VaultPage({
    Key? key,
    this.item,
    this.isChat = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VaultController vaultController = Get.put(VaultController());
    final isGridView = true.obs;

    Folder folder = Controller.to.all[Controller.to.selectedFolder.value];

    // RxList<HomeItem> childrens =
    //     Controller.to.all[Controller.to.selectedFolder.value].childrens;

    // RxList lockedItems = [].obs;

    // getLockedItems() {
    //   if (isChat) {
    //     Chat? chat;
    //     chat = childrens[Controller.to.selectedElementIndex.value].child;
    //     for (int i = 0; i < chat!.messages.length; i++) {
    //       if (chat.messages[i].type == ChatType.message &&
    //           chat.messages[i].isLocked) {
    //         lockedItems.add(chat.messages[i]);
    //       }
    //     }
    //   } else {
    //     for (var item in childrens) {
    //       if (item.isLocked) {
    //         lockedItems.add(item);
    //       }
    //     }
    //   }
    // }

    // getLockedItems();

    passwordIsNotNull() {
      if (item != null) {
        if (isChat) {
          final ChatController chatController = Get.find();
          final Chat chat = chatController.homeItem.child;
          RxList messages = chat.messages;
          Get.back();
          item.isLocked = item.isUnlocked && item.isLocked ? false : true;
          item.isUnlocked = !item.isUnlocked;
          messages[messages.indexOf(item)] = item;
          chat.copyWith(messages: messages);
        } else {
          item.copyWith(isLocked: !item.isLocked);
        }
      }
      vaultController.isUnblocked.value = true;
    }

    return Obx(() => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          actions: vaultController.isUnblocked.value
              ? [
                  IconButton(
                    onPressed: () {
                      isGridView.value = !isGridView.value;
                    },
                    icon: Obx(() =>
                        Icon(isGridView.value ? Icons.list : Icons.grid_view)),
                    splashRadius: 20,
                  ),
                ]
              : null,
          leading: IconButton(
              splashRadius: 20,
              onPressed: () {
                ChatController chatController = Get.put(ChatController());
                isChat ? chatController.isVault.value = false : null;
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text('Vault'),
        ),
        body: vaultController.isUnblocked.value
            ? MasonryGridView.count(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                crossAxisCount: isGridView.value ? 2 : 1,
                itemCount: isChat
                    ? folder.childrens[Controller.to.selectedElementIndex.value]
                        .child
                        .getVaultChildrens()
                        .length
                    : folder.getVaultChildrens().length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: isChat
                        ? MessageWidget(
                            message: folder
                                .childrens[
                                    Controller.to.selectedElementIndex.value]
                                .child
                                .getVaultChildrens()[index],
                            isVault: true)
                        : HomeBodyItem(
                            homeItem: folder.getVaultChildrens()[index],
                            homeItemIndex: index,
                          ),
                  );
                })
            : const VaultPagePasswordWidget(),
        bottomNavigationBar: const HomeBottomBar(isVault: true),
        floatingActionButton: vaultController.isUnblocked.value
            ? null
            : FloatingActionButton(
                onPressed: () {
                  if (vaultController.passwordController.text ==
                      vaultController.repeatPasswordController.text) {
                    Controller.to.password =
                        vaultController.passwordController.text.obs;
                    Controller.to.setData();
                    if (Controller.to.password.isEmpty) {
                      Get.back();
                    } else {
                      passwordIsNotNull();
                      // getLockedItems();
                    }
                  } else if (vaultController.passwordController.text ==
                      Controller.to.password.value) {
                    passwordIsNotNull();
                  }
                },
                backgroundColor: Colors.blue,
                child: const Icon(
                  Icons.done,
                  color: Colors.white,
                ),
              )));
  }
}
