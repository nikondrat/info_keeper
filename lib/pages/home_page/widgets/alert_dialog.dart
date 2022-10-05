import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/item_location.dart';

class HomeAlertDialog extends StatelessWidget {
  const HomeAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    final validate = false.obs;

    void addChat(String text) {
      if (text.isNotEmpty) {
        validate.value = false;
        Controller.to.add(HomeItem(
            name: text,
            child: Chat(messages: [].obs),
            location: ItemLocation(
                inDirectory: Controller.to.selectedFolder.value,
                index: Controller.to.all[Controller.to.selectedFolder.value]
                    .childrens.length)));
        Navigator.pop(context, 'Create');
      }
      validate.value = true;
    }

    return AlertDialog(
      title: const Text('Enter chat name'),
      content: Obx(() => TextField(
          autofocus: true,
          maxLength: 18,
          controller: controller,
          decoration: InputDecoration(
            errorText: validate.value ? 'Value Can\'t Be Empty' : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          ),
          onSubmitted: addChat)),
      actions: [
        TextButton(
          onPressed: () => addChat(controller.text),
          child: const Text(
            'Create',
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
        )
      ],
    );
  }
}
