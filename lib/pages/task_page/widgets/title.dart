import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskTitle extends StatelessWidget {
  final TextEditingController titleController;
  final RxBool changeTitle;
  final RxBool addTodo;
  const TaskTitle(
      {Key? key,
      required this.titleController,
      required this.changeTitle,
      required this.addTodo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextField titleTextField = TextField(
      controller: titleController,
      cursorColor: Colors.black,
      autofocus: true,
      maxLength: 20,
      decoration: InputDecoration(
          hintText: 'Write title',
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          counterText: '',
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.red)),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          disabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6))),
      onSubmitted: (value) {
        titleController.text = value;
        value.isNotEmpty ? changeTitle.value = false : null;
      },
    );

    return Obx(() => changeTitle.value
        ? titleTextField
        : TextButton(
            onPressed: () {
              addTodo.value = false;
              changeTitle.value = !changeTitle.value;
              titleController.selection = TextSelection(
                  baseOffset: 0, extentOffset: titleController.text.length);
            },
            child: AutoSizeText(
              titleController.text,
              style: const TextStyle(fontSize: 18),
            ),
          ));
  }
}
