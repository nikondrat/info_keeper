import 'package:flutter/material.dart';

class TodoPageTextField extends StatelessWidget {
  final TextEditingController titleController;
  final bool change;
  const TodoPageTextField(
      {Key? key, this.change = false, required this.titleController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: titleController,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          hintText: 'Title',
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(width: 1, color: Colors.red)),
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
      onSubmitted: (value) {},
    );
  }
}
