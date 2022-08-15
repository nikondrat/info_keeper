import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/pages/chat_page/widgets/type/chat_image.dart';
import 'package:info_keeper/pages/chat_page/widgets/type/chat_message.dart';
import 'package:info_keeper/pages/home_page/home_widget/home_widget.dart';

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
            builder: (context, constraints) => Obx(() => Controller
                    .to.trashElements.isNotEmpty
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
                        case AllType.chatMessage:
                          return MessageWidgetBody(
                              index: index,
                              isTrash: true,
                              dateTime:
                                  Controller.to.trashElements[index].dateTime,
                              message: Controller.to.trashElements[index]);
                        case AllType.chatImage:
                          return ChatImageWidget(
                              isTrash: true,
                              path: Controller.to.trashElements[index].path,
                              dateTime:
                                  Controller.to.trashElements[index].dateTime,
                              showDate: false.obs);
                        default:
                      }
                      return HomeWidget(
                        isTrash: true,
                        value: Controller.to.trashElements[index],
                        index: index,
                      );
                    })
                : const SizedBox.shrink())));
  }
}
