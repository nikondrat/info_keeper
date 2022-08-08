import 'dart:io';

import 'package:flutter/material.dart';

class BackgroundImageWidget extends StatelessWidget {
  final Widget child;
  final String image;
  const BackgroundImageWidget(
      {Key? key, required this.child, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: FileImage(File(image)), fit: BoxFit.cover)),
        child: child);
  }
}
