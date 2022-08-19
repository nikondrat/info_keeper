import 'package:flutter/material.dart';
import 'package:info_keeper/model/controller.dart';

class FolderItemMenu extends StatelessWidget {
  final int index;
  const FolderItemMenu({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: TextButton(
                onPressed: () {
                  var data = Controller
                      .to
                      .all[Controller.to.selectedFolder.value]
                      .childrens[Controller.to.selectedElementIndex.value];
                  Controller
                      .to.all[Controller.to.selectedFolder.value].childrens
                      .removeAt(Controller.to.selectedElementIndex.value);
                  Controller.to.selectedFolder.value = index;
                  Controller.to.add(data);
                  Controller.to.selectedFolder.value = index;
                  Navigator.pop(context);
                },
                child: const Text('MOVE'))),
        Expanded(
          child: TextButton(
            onPressed: () {
              var element = Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .childrens[Controller.to.selectedElementIndex.value];

              Controller.to.addLink(element, index);
              Controller.to.selectedFolder.value = index;
              Navigator.pop(context);
            },
            child: const Text('LINK'),
          ),
        ),
      ],
    );
  }
}
