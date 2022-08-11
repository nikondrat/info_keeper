import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/pages/chat_page/widgets/type/chat_message.dart';

class ChatPageSearch extends StatelessWidget {
  const ChatPageSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchQueryController = TextEditingController();
    RxList searchResult = [].obs;
    List list = [].obs;

    for (int i = 0;
        i <
            Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .messages!
                .length;
        i++) {
      if (Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .directoryChildrens[Controller.to.selectedElementIndex.value]
                  .messages![i]
                  .type ==
              AllType.chatMessage &&
          !Controller
              .to
              .all[Controller.to.selectedFolder.value]
              .directoryChildrens[Controller.to.selectedElementIndex.value]
              .messages![i]
              .isLocked) {
        list.add(Controller
            .to
            .all[Controller.to.selectedFolder.value]
            .directoryChildrens[Controller.to.selectedElementIndex.value]
            .messages![i]);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            splashRadius: 20,
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            onPressed: () {
              searchQueryController.clear();
              searchResult.clear();
            },
            icon: const Icon(Icons.close),
            splashRadius: 20,
          )
        ],
        title: TextField(
          autofocus: true,
          autocorrect: true,
          controller: searchQueryController,
          cursorColor: Colors.black,
          decoration:
              const InputDecoration(border: InputBorder.none, hintText: 'Text'),
          onChanged: (text) {
            searchResult.clear();
            for (var element in list) {
              if (element.messageText.toLowerCase().contains(text) ||
                  element.title.toLowerCase().contains(text)) {
                if (searchQueryController.text.isNotEmpty) {
                  searchResult.add(element);
                }
              }
            }
          },
        ),
      ),
      body: Obx(() => ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          itemCount: searchResult.length,
          itemBuilder: (context, index) {
            return MessageWidgetBody(
                dateTime: Controller
                    .to
                    .all[Controller.to.selectedFolder.value]
                    .directoryChildrens[
                        Controller.to.selectedElementIndex.value]
                    .messages![index]
                    .dateTime,
                term: searchQueryController.text,
                message: searchResult[index]);
          })),
    );
  }
}
