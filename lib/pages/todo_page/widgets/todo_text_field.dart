import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoPageTextField extends StatelessWidget {
  final TextEditingController titleController;
  final bool change;
  const TodoPageTextField(
      {Key? key, this.change = false, required this.titleController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool changeTitle = false.obs;
    return Obx(
      () => changeTitle.value
          ? TextField(
              controller: titleController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  hintText: 'Title',
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
              onSubmitted: (value) {
                value.isNotEmpty ? changeTitle.value = false : null;
              },
            )
          : TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(20))),
              onPressed: () => changeTitle.value = true,
              child: Text(titleController.text.isEmpty
                  ? 'Click to set name'
                  : titleController.text),
            ),
    );
  }
}
