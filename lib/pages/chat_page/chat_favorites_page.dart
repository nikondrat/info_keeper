import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/pages/chat_page/widgets/type/chat_message.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ChatPageFavorites extends StatelessWidget {
  final AutoScrollController autoScrollController;
  final RxBool splitMessages;
  const ChatPageFavorites(
      {Key? key,
      required this.autoScrollController,
      required this.splitMessages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showDate = false.obs;

    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                splashRadius: 20,
                onPressed: () {
                  showDate.value = !showDate.value;
                },
                icon: const Icon(Icons.date_range))
          ],
          title: const Text('Favorites'),
          centerTitle: false,
          leading: IconButton(
            splashRadius: 20,
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          )),
      body: LayoutBuilder(
        builder: (context, constraints) => Obx(() => showDate.value
            ? ChatPageFavoritesBody(
                autoScrollController: autoScrollController,
                showDate: showDate,
                splitMessages: splitMessages)
            : ChatPageFavoritesBody(
                autoScrollController: autoScrollController,
                showDate: showDate,
                splitMessages: splitMessages)),
      ),
    );
  }
}

class ChatPageFavoritesBody extends StatelessWidget {
  final AutoScrollController autoScrollController;
  final RxBool splitMessages;
  final RxBool showDate;

  const ChatPageFavoritesBody(
      {Key? key,
      required this.autoScrollController,
      required this.showDate,
      required this.splitMessages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RxList messages = [].obs;

    for (int i = 0;
        i <
            Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .favorites!
                .length;
        i++) {
      if (!Controller
          .to
          .all[Controller.to.selectedFolder.value]
          .directoryChildrens[Controller.to.selectedElementIndex.value]
          .messages![i]
          .isLocked) {
        messages.add(Controller
            .to
            .all[Controller.to.selectedFolder.value]
            .directoryChildrens[Controller.to.selectedElementIndex.value]
            .messages![i]);
      }
    }
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        physics: const BouncingScrollPhysics(),
        itemCount: messages.length,
        itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                autoScrollController.scrollToIndex(index,
                    preferPosition: AutoScrollPosition.begin);
                Get.back();
              },
              child: MessageWidgetBody(
                  splitMessages: splitMessages,
                  showDate: showDate,
                  dateTime: messages[index].dateTime,
                  message: messages[index]),
            ));
  }
}
