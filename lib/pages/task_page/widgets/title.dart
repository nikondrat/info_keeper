import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskTitle extends StatelessWidget {
  final TextEditingController titleController;
  final RxBool changeTitle;
  final RxBool addTodo;
  final FocusNode titleFocus;
  const TaskTitle(
      {Key? key,
      required this.titleController,
      required this.changeTitle,
      required this.titleFocus,
      required this.addTodo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextField titleTextField = TextField(
      controller: titleController,
      cursorColor: Colors.black,
      maxLength: 20,
      focusNode: titleFocus,
      onTap: () => changeTitle.value = true,
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

    return titleTextField;
  }
}
