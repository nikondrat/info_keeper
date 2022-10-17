import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/btm_app_bar/btm_app_bar_controller.dart';

class BottomAppBarEditMessageWidget extends StatelessWidget {
  const BottomAppBarEditMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomAppBarController barController = Get.find();

    return ListTile(
      minVerticalPadding: 0,
      visualDensity: VisualDensity.compact,
      title: AutoSizeText(
        'Edit',
        style: TextStyle(color: Theme.of(context).textTheme.headline6!.color),
      ),
      subtitle: AutoSizeText(
        barController.editMessageText.value,
        maxLines: 1,
        style: TextStyle(color: Theme.of(context).textTheme.headline4!.color),
        textAlign: TextAlign.justify,
      ),
      style: ListTileStyle.drawer,
      leading: Icon(Icons.edit_outlined,
          color: Theme.of(context).textTheme.headline4!.color),
      trailing: IconButton(
          splashRadius: 20,
          onPressed: () {
            barController.isEditMessage.value = false;
            barController.titleController.clear();
            barController.messageController.clear();
            FocusScope.of(context).unfocus();
            barController.textFieldIsEmpty.value = true;
          },
          icon: Icon(Icons.close,
              color: Theme.of(context).textTheme.headline6!.color)),
    );
  }
}
