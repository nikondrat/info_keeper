import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/pages/vault_page/vault_controller.dart';

class VaultPagePasswordWidget extends StatelessWidget {
  const VaultPagePasswordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          physics: const BouncingScrollPhysics(),
          children: [
            const VaultPagePasswordWidgetBody(title: 'Enter password'),
            Controller.to.password.isEmpty
                ? const VaultPagePasswordWidgetBody(
                    title: 'Repeat password', isRepeatPasswordWidget: true)
                : const SizedBox(),
            Controller.to.password.isEmpty
                ? const ListTile(
                    style: ListTileStyle.drawer,
                    minLeadingWidth: 0,
                    leading: Icon(
                      Icons.info_outline,
                      color: Colors.blue,
                    ),
                    title: AutoSizeText(
                        'The vault is available by swiping the screen to the right.'),
                  )
                : const SizedBox(),
            Controller.to.password.isEmpty
                ? const ListTile(
                    style: ListTileStyle.drawer,
                    minLeadingWidth: 0,
                    leading: Icon(
                      Icons.error_outline,
                      color: Colors.orange,
                    ),
                    title: AutoSizeText('The password cannot be restored.'),
                  )
                : const SizedBox()
          ],
        ));
  }
}

class VaultPagePasswordWidgetBody extends StatelessWidget {
  final String title;
  final bool isRepeatPasswordWidget;
  const VaultPagePasswordWidgetBody(
      {Key? key, required this.title, this.isRepeatPasswordWidget = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VaultController vaultController = Get.find();
    final isVisible = false.obs;

    final RxString password = ''.obs;

    String? error() {
      if (password.isEmpty) {
        return 'Password Can\'t Be Empty';
      } else if (password.value.length < 6) {
        return 'The password cannot be short. Minimum of 6 characters';
      } else if (isRepeatPasswordWidget &&
          vaultController.passwordController.text !=
              vaultController.repeatPasswordController.text) {
        return 'Passwords are different';
      }
      return null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4, top: 6),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Obx(() => TextField(
              controller: isRepeatPasswordWidget
                  ? vaultController.repeatPasswordController
                  : vaultController.passwordController,
              onTap: () {
                if (isVisible.value) {
                  isVisible.value = !isVisible.value;
                }
              },
              autofocus: true,
              obscuringCharacter: '*',
              cursorColor: Colors.black,
              obscureText: !isVisible.value,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      color: Colors.black,
                      splashRadius: 20,
                      onPressed: () => isVisible.value = !isVisible.value,
                      icon: isVisible.value
                          ? const Icon(Icons.visibility_off_outlined)
                          : const Icon(Icons.visibility_outlined)),
                  errorText: error(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.red)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide()),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide()),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide()),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(),
                  )),
              onChanged: (value) {
                password.value = isRepeatPasswordWidget
                    ? vaultController.repeatPasswordController.text
                    : vaultController.passwordController.text;
              },
              onSubmitted: (value) {},
            )),
      ],
    );
  }
}
