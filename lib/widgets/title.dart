import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TitleWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final RxBool change;
  const TitleWidget(
      {Key? key,
      required this.controller,
      this.focusNode,
      required this.change})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextField titleTextField = TextField(
      controller: controller,
      cursorColor: Colors.black,
      maxLength: 22,
      focusNode: focusNode,
      onTap: () => change.value = true,
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
        controller.text = value;
        value.isNotEmpty ? change.value = false : null;
      },
    );

    return titleTextField;
  }
}
