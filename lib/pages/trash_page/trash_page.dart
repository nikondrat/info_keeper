import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/chat_type.dart';
import 'package:info_keeper/model/types/trash/trash_item.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/file.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/image.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/message/widgets/body.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/voice.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item.dart';

class TrashPage extends StatelessWidget {
  const TrashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxList<TrashItem> trashElements = Controller.to.trashElements;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text('Trash bin'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            splashRadius: 20,
            onPressed: () => Get.back(),
          ),
          actions: [
            IconButton(
                splashRadius: 20,
                onPressed: () {
                  Controller.to.trashElements.clear();
                  Controller.to.setData();
                },
                icon: const Icon(Icons.delete_outline))
          ],
        ),
        body: Obx(() => MasonryGridView.count(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 1,
            itemCount: Controller.to.trashElements.length,
            itemBuilder: (context, index) {
              if (!trashElements[index].isMessage) {
                return HomeBodyItem(
                    homeItemIndex: index, homeItem: trashElements[index].child);
              } else {
                switch (trashElements[index].child.type) {
                  case ChatType.voice:
                    return ChatVoiceWidget(
                      voice: trashElements[index].child,
                    );
                  case ChatType.file:
                    return ChatFileWidget(file: trashElements[index].child);
                  case ChatType.message:
                    return MessageWidgetBody(
                        isTrash: true,
                        message: Controller.to.trashElements[index].child);
                  case ChatType.image:
                    return ChatImageWidget(image: trashElements[index].child);
                }
              }
              return const SizedBox();
            })));
  }
}
