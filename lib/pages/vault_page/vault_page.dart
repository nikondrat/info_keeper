import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/old_chat.dart';
import 'package:info_keeper/pages/home_page/home_widget/home_widget.dart';
import 'package:info_keeper/pages/home_page/widgets/home_btm_nav_bar.dart';
import 'package:info_keeper/pages/vault_page/vault_password.dart';

class VaultPage extends StatelessWidget {
  final RxList? childrens;
  final RxInt selectedElement;
  final bool isChat;
  final bool first;

  const VaultPage(
      {Key? key,
      this.childrens,
      this.isChat = false,
      this.first = false,
      required this.selectedElement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController repeatPasswordController = TextEditingController();
    final isGridView = true.obs;
    final isUnblocked = false.obs;

    return Obx(() => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          actions: isUnblocked.value
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
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back)),
          title: const Text('Vault'),
        ),
        body: isUnblocked.value && childrens != null
            ? MasonryGridView.count(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                crossAxisCount: isGridView.value ? 2 : 1,
                itemCount: childrens!.length,
                itemBuilder: (context, index) {
                  return childrens![index].isLocked
                      ? Padding(
                          padding: const EdgeInsets.all(5),
                          child: HomeWidget(
                            homeItem: childrens![index],
                            isVault: true,
                            index: index,
                          ),
                        )
                      : Container();
                })
            : VaultPagePasswordWidget(
                passwordController: passwordController,
                repeatPasswordController: repeatPasswordController),
        bottomNavigationBar: const HomePageBottomNavigationBar(isVault: true),
        floatingActionButton: isUnblocked.value
            ? null
            : FloatingActionButton(
                onPressed: () {
                  messageFunc() {
                    List messages = Controller
                        .to
                        .all[Controller.to.selectedFolder.value]
                        .childrens[Controller.to.selectedElementIndex.value]
                        .child
                        .value
                        .messages;
                    if (passwordController.text ==
                        repeatPasswordController.text) {
                      messages[selectedElement.value].isLocked =
                          !messages[selectedElement.value].isLocked;

                      messages[selectedElement.value].isUnlocked = true;

                      Controller.to.password = passwordController.text.obs;
                      Controller.to.change(ChatItem(messages: messages.obs));
                    }
                    if (passwordController.text ==
                        Controller.to.password.value) {
                      messages[selectedElement.value].isUnlocked = true;

                      messages[selectedElement.value].isLocked =
                          !messages[selectedElement.value].isLocked;
                      isUnblocked.value = true;
                      Controller.to.change(ChatItem(messages: messages.obs));
                    }
                    if (messages[selectedElement.value].isUnlocked) {
                      const Duration(minutes: 2).delay().then((value) {
                        messages[selectedElement.value].isLocked = true;
                        messages[selectedElement.value].isUnlocked = false;
                        Controller.to.change(ChatItem(messages: messages.obs));
                      });
                    }
                    Get.back();
                  }

                  homeFunc() {
                    if (passwordController.text ==
                        repeatPasswordController.text) {
                      Controller.to.password = passwordController.text.obs;
                      Controller.to.setData();
                      if (first) {
                        Get.back();
                      } else {
                        isUnblocked.value = true;
                      }
                    } else if (passwordController.text ==
                        Controller.to.password.value) {
                      isUnblocked.value = true;
                    }
                  }

                  isChat ? messageFunc() : homeFunc();
                },
                backgroundColor: Colors.blue,
                child: const Icon(
                  Icons.done,
                  color: Colors.white,
                ),
              )));
  }
}
