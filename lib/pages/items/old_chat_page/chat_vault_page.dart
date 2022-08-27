import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/pages/items/old_chat_page/widgets/type/chat_message.dart';
import 'package:info_keeper/pages/vault_page/vault_password.dart';

class ChatPageVault extends StatelessWidget {
  const ChatPageVault({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List lockedMessages = [];

    TextEditingController passwordController = TextEditingController();
    TextEditingController repeatPasswordController = TextEditingController();
    final isUnblocked = false.obs;

    for (int i = 0;
        i <
            Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value]
                .child
                .value
                .messages!
                .length;
        i++) {
      if (Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .childrens[Controller.to.selectedElementIndex.value]
                  .child
                  .value
                  .messages![i]
                  .type ==
              AllType.chatMessage &&
          Controller
              .to
              .all[Controller.to.selectedFolder.value]
              .childrens[Controller.to.selectedElementIndex.value]
              .child
              .value
              .messages![i]
              .isLocked) {
        lockedMessages.add(Controller
            .to
            .all[Controller.to.selectedFolder.value]
            .childrens[Controller.to.selectedElementIndex.value]
            .child
            .value
            .messages![i]);
      }
    }

    return Obx(() => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: IconButton(
              splashRadius: 20,
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back)),
          title: const Text('Vault'),
        ),
        body: isUnblocked.value
            ? ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                physics: const BouncingScrollPhysics(),
                itemCount: lockedMessages.length,
                itemBuilder: (context, index) => MessageWidgetBody(
                    dateTime: Controller
                        .to
                        .all[Controller.to.selectedFolder.value]
                        .childrens[Controller.to.selectedElementIndex.value]
                        .child
                        .value
                        .messages![index]
                        .dateTime,
                    message: lockedMessages[index]))
            : VaultPagePasswordWidget(
                passwordController: passwordController,
                repeatPasswordController: repeatPasswordController),
        floatingActionButton: isUnblocked.value
            ? null
            : FloatingActionButton(
                onPressed: () {
                  if (passwordController.text ==
                      repeatPasswordController.text) {
                    Controller.to.password = passwordController.text.obs;
                    Controller.to.setData();
                    isUnblocked.value = true;
                  } else if (passwordController.text ==
                      Controller.to.password.value) {
                    isUnblocked.value = true;
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
