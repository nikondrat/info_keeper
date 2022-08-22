import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/item_location.dart';

class HomePageAlertDialog extends StatelessWidget {
  const HomePageAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    final validate = false.obs;

    return AlertDialog(
      title: const Text('Enter chat name'),
      content: Obx(
        () => TextField(
          autofocus: true,
          maxLength: 18,
          controller: controller,
          cursorColor: Colors.black,
          decoration: InputDecoration(
              errorText: validate.value ? 'Value Can\'t Be Empty' : null,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(width: 1, color: Colors.red)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    width: 1,
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    width: 1,
                  )),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    width: 1,
                  )),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  width: 1,
                ),
              )),
          onSubmitted: (String value) {
            if (value.isNotEmpty) {
              validate.value = false;
              Controller.to.add(HomeItem(
                  name: value,
                  child: Chat(
                          favorites: [].obs,
                          pinnedMessages: [].obs,
                          messages: [].obs)
                      .obs,
                  location: ItemLocation(
                      inDirectory: Controller.to.selectedFolder.value,
                      index: Controller
                              .to
                              .all[Controller.to.selectedFolder.value]
                              .childrens
                              .length -
                          1)));
              Navigator.pop(context, 'Create');
            }
            validate.value = true;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              validate.value = false;
              Controller.to.add(HomeItem(
                  name: controller.text,
                  child: Chat(
                          favorites: [].obs,
                          pinnedMessages: [].obs,
                          messages: [].obs)
                      .obs,
                  location: ItemLocation(
                      inDirectory: Controller.to.selectedFolder.value,
                      index: Controller
                              .to
                              .all[Controller.to.selectedFolder.value]
                              .childrens
                              .length -
                          1)));

              Navigator.pop(context, 'Create');
            }
            validate.value = true;
          },
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
