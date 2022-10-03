import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TitleWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final RxBool change;
  const TitleWidget(
      {Key? key,
      required this.controller,
      required this.focusNode,
      required this.change})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextField titleTextField = TextField(
      controller: controller,
      maxLength: 22,
      focusNode: focusNode,
      onTap: () => change.value = true,
      decoration: const InputDecoration(
        hintText: 'Write title',
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        counterText: '',
      ),
      onSubmitted: (value) {
        controller.text = value;
        value.isNotEmpty ? change.value = false : null;
      },
    );

    return titleTextField;
  }
}
