import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/chat/chat.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/location_element.dart';

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
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              validate.value = false;
              Controller.to.add(Chat(
                  location: LocationElement(
                      inDirectory: Controller.to.selectedFolder.value,
                      index: Controller
                              .to
                              .all[Controller.to.selectedFolder.value]
                              .directoryChildrens
                              .length -
                          1),
                  name: value,
                  favorites: [].obs,
                  pinnedMessages: [].obs,
                  messages: [].obs));
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
              Controller.to.add(Chat(
                  location: LocationElement(
                      inDirectory: Controller.to.selectedFolder.value,
                      index: Controller
                              .to
                              .all[Controller.to.selectedFolder.value]
                              .directoryChildrens
                              .length -
                          1),
                  name: controller.text,
                  pinnedMessages: [].obs,
                  favorites: [].obs,
                  messages: [].obs));

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
