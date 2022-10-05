import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';

class TrashElement extends StatelessWidget {
  final RxBool isShowRestoreMenu;
  final int? index;
  final Widget child;
  final bool isMessage;
  const TrashElement(
      {Key? key,
      required this.isShowRestoreMenu,
      required this.child,
      this.isMessage = false,
      this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
    // return Obx(() => isShowRestoreMenu.value
    //     ? Container(
    //         padding: const EdgeInsets.symmetric(horizontal: 4),
    //         decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(6),
    //             border: Border.all(color: Colors.grey.shade600)),
    //         child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             children: [
    //               TextButton(
    //                   onPressed: () => isShowRestoreMenu.value = false,
    //                   child: const Text('Cancel')),
    //               TextButton(
    //                   onPressed: () {
    //                     isMessage
    //                         ? Controller
    //                             .to
    //                             .all[Controller.to.trashElements[index!]
    //                                 .location.inDirectory]
    //                             .childrens[Controller
    //                                 .to.trashElements[index!].location.index]
    //                             .child
    //                             .value
    //                             .messages
    //                             .insert(
    //                                 Controller.to.trashElements[index!].location
    //                                     .selectedMessageIndex,
    //                                 Controller.to.trashElements[index!])
    //                         : Controller
    //                             .to
    //                             .all[Controller.to.trashElements[index!]
    //                                 .location.inDirectory]
    //                             .childrens
    //                             .insert(
    //                                 Controller.to.trashElements[index!].location
    //                                     .index,
    //                                 Controller.to.trashElements[index!]);
    //                     Controller.to.trashElements.removeAt(index!);
    //                     Controller.to.setData();
    //                   },
    //                   child: const Text('Restore'))
    //             ]),
    //       )
    //     : child);
  }
}
