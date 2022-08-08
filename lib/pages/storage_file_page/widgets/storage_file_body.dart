import 'package:flutter/material.dart';

class StorageFilePageBody extends StatelessWidget {
  final TextEditingController dataController;
  const StorageFilePageBody({Key? key, required this.dataController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                autocorrect: true,
                controller: dataController,
                maxLines: null,
                expands: true,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Text'),
                onFieldSubmitted: (value) {},
              )),
        ),
      ],
    );
  }
}
