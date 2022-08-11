import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/pages/chat_page/widgets/type/chat_message.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ChatPageTitles extends StatelessWidget {
  final RxBool splitMessages;
  final AutoScrollController autoScrollController;
  const ChatPageTitles(
      {Key? key,
      required this.splitMessages,
      required this.autoScrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List titlesMessages = [];

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
        titlesMessages.add(Controller
            .to
            .all[Controller.to.selectedFolder.value]
            .directoryChildrens[Controller.to.selectedElementIndex.value]
            .messages![i]);
      }
    }

    return Scaffold(
        appBar: AppBar(
            title: const Text('Titles'),
            centerTitle: false,
            leading: IconButton(
              splashRadius: 20,
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            )),
        body: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            physics: const BouncingScrollPhysics(),
            itemCount: titlesMessages.length,
            itemBuilder: (context, index) {
              // titlesMessages.sort((a, b) => a.title.compareTo(b.title));

              if (titlesMessages[index].title.isNotEmpty) {
                return GestureDetector(
                  onTap: () {
                    autoScrollController.scrollToIndex(index,
                        preferPosition: AutoScrollPosition.begin);
                    Get.back();
                  },
                  child: MessageWidgetBody(
                    splitMessages: splitMessages,
                    message: titlesMessages[index],
                    dateTime: titlesMessages[index].dateTime,
                    showDate: RxBool(false),
                  ),
                );
              }
              return Container();
            }));
  }
}
