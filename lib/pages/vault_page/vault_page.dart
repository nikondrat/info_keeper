import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/folder.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';
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
    HomeController home = Get.put(HomeController());
    final isGridView = true.obs;

    Folder folder = Controller.to.all[Controller.to.selectedFolder.value];

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

    return Obx(() => GestureDetector(
          onTap: () {
            if (home.isShowBottomMenu.value) {
              home.isShowBottomMenu.value = false;
            }
          },
          child: Scaffold(
              appBar: AppBar(
                centerTitle: false,
                actions: vaultController.isUnblocked.value
                    ? [
                        IconButton(
                          onPressed: () {
                            isGridView.value = !isGridView.value;
                          },
                          icon: Obx(() => Icon(
                              isGridView.value ? Icons.list : Icons.grid_view)),
                          splashRadius: 20,
                        ),
                      ]
                    : null,
                leading: IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      ChatController chatController = Get.put(ChatController());
                      isChat ? chatController.isVault.value = false : null;
                      if (home.isShowBottomMenu.value) {
                        home.isShowBottomMenu.value = false;
                      }
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back)),
                title: const Text('Vault'),
              ),
              body: Obx(() => vaultController.isUnblocked.value
                  ? MasonryGridView.count(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      crossAxisCount: isChat
                          ? isGridView.value
                              ? 1
                              : 2
                          : isGridView.value
                              ? 2
                              : 1,
                      itemCount: isChat
                          ? folder
                              .childrens[
                                  Controller.to.selectedElementIndex.value]
                              .child
                              .messages
                              .length
                          : folder.childrens.length,
                      itemBuilder: (context, index) {
                        if (isChat) {
                          return !folder
                                  .childrens[
                                      Controller.to.selectedElementIndex.value]
                                  .child
                                  .messages[index]
                                  .isLocked
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 3),
                                  child: MessageWidget(
                                      message: folder
                                          .childrens[Controller
                                              .to.selectedElementIndex.value]
                                          .child
                                          .messages[index],
                                      isVault: true),
                                );
                        }

                        return !folder.childrens[index].isLocked
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.all(5),
                                child: folder.childrens[index].isLocked
                                    ? HomeBodyItem(
                                        homeItem: folder.childrens[index],
                                        homeItemIndex: index,
                                      )
                                    : const SizedBox(),
                              );
                      })
                  : const VaultPagePasswordWidget()),
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
                    )),
        ));
  }
}
