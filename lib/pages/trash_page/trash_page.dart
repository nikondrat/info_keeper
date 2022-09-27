import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/chat_type.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/file.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/image.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/message/message.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/voice.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item.dart';

class TrashPage extends StatelessWidget {
  const TrashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        body: LayoutBuilder(
            builder: (context, constraints) => Obx(() =>
                Controller.to.trashElements.isNotEmpty
                    ? MasonryGridView.count(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 2,
                        itemCount: Controller.to.trashElements.length,
                        itemBuilder: (context, index) {
                          switch (Controller.to.trashElements[index].type) {
                            case ChatType.voice:
                              return ChatVoiceWidget(
                                voice: Controller.to.trashElements[index],
                              );
                            case ChatType.file:
                              return ChatFileWidget(
                                  file: Controller.to.trashElements[index]);
                            case ChatType.message:
                              return MessageWidget(
                                  message: Controller.to.trashElements[index]);
                            case ChatType.image:
                              return ChatImageWidget(
                                  image: Controller.to.trashElements[index]);
                            default:
                          }
                          return HomeBodyItem(
                              homeItemIndex: index,
                              homeItem: Controller.to.trashElements[index]);
                        })
                    : const SizedBox.shrink())));
  }
}
