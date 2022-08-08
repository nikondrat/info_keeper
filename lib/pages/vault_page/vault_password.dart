import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';

class VaultPagePasswordWidget extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;
  const VaultPagePasswordWidget(
      {Key? key,
      required this.passwordController,
      required this.repeatPasswordController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          physics: const BouncingScrollPhysics(),
          children: [
            VaultPagePasswordWidgetBody(
                title: 'Enter password', controller: passwordController),
            Controller.to.password.isEmpty
                ? VaultPagePasswordWidgetBody(
                    title: 'Repeat password',
                    controller: repeatPasswordController)
                : Container(),
          ],
        ));
  }
}

class VaultPagePasswordWidgetBody extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool isRepeatPasswordWidget;
  const VaultPagePasswordWidgetBody(
      {Key? key,
      required this.title,
      required this.controller,
      this.isRepeatPasswordWidget = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final validate = false.obs;
    final isVisible = false.obs;

    String? error() {
      if (validate.value) {
        return 'Value Can\'t Be Empty';
      }
      return null;
    }

    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4, top: 6),
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              controller: controller,
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
                      borderSide:
                          const BorderSide(width: 1, color: Colors.red)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(
                        width: 1,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(
                        width: 1,
                      )),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(
                        width: 1,
                      )),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      width: 1,
                    ),
                  )),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  validate.value = false;
                } else {
                  validate.value = true;
                }
              },
              onSubmitted: (value) {},
            ),
          ],
        ));
  }
}
