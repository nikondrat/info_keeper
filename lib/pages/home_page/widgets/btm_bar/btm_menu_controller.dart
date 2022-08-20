import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';

class BottomMenuController extends GetxController {
  final List childrens =
      Controller.to.all[Controller.to.selectedFolder.value].childrens;

  void pinItem(dynamic item) {
    final int itemIndex = childrens.indexOf(item);
    childrens[itemIndex].pin();
    childrens.sort((a, b) => a.isPinned ? 0 : 1);
    Controller.to.setData();
  }

  void animateItem(dynamic item) {
    final itemIndex = childrens.indexOf(item);
    childrens[itemIndex].animate();
    Controller.to.setData();
  }
}
