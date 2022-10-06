import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';

class TrashElement extends StatelessWidget {
  final int index;
  final Widget child;
  final dynamic data;
  final bool isMessage;
  const TrashElement(
      {Key? key,
      required this.index,
      required this.child,
      required this.data,
      this.isMessage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RxBool isShowRestoreMenu = false.obs;

    return Obx(() => isShowRestoreMenu.value
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade600)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () => isShowRestoreMenu.value = false,
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () {
                        isMessage
                            ? Controller.to.all[data.location.inDirectory]
                                .childrens[data.location.index].child.messages
                                .insert(data.location.itemIndex, data)
                            : Controller
                                .to.all[data.location.inDirectory].childrens
                                .insert(data.location.index, data);
                        Controller.to.trashElements.removeAt(index);
                        Controller.to.setData();
                      },
                      child: const Text('Restore'))
                ]),
          )
        : GestureDetector(
            onLongPress: () =>
                isShowRestoreMenu.value = !isShowRestoreMenu.value,
            child: child));
  }
}
