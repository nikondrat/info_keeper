import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/body.dart';
import 'package:info_keeper/pages/items/chat/widgets/btm_app_bar/btm_app_bar.dart';
import 'package:info_keeper/widgets/app_bar/widgets/title.dart';
import 'package:swipe/swipe.dart';

class ChatPage extends StatelessWidget {
  final HomeItem homeItem;
  const ChatPage({Key? key, required this.homeItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());
    // title
    TextEditingController titleController =
        TextEditingController(text: homeItem.name);
    FocusNode titleFocus = FocusNode();

    return Swipe(
      onSwipeRight: () => null,
      child: Obx(() => Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                titleSpacing: controller.changeTitle.value ? 0 : null,
                centerTitle: false,
                leading: IconButton(
                    splashRadius: 20,
                    icon: Icon(controller.changeTitle.value
                        ? Icons.close
                        : Icons.arrow_back),
                    onPressed: controller.changeTitle.value
                        ? () {
                            controller.changeTitle.value =
                                !controller.changeTitle.value;
                            titleFocus.unfocus();
                            titleController.text = homeItem.name;
                          }
                        : () => Get.back()),
                actions: controller.changeTitle.value
                    ? [
                        IconButton(
                            splashRadius: 20,
                            onPressed: () {
                              if (titleController.text.isNotEmpty) {
                                controller.changeTitle.value =
                                    !controller.changeTitle.value;
                                titleFocus.unfocus();
                                // defaultName = titleController.text;
                                homeItem.copyWith(name: titleController.text);

                                Controller.to.setData();
                              }
                            },
                            icon: const Icon(Icons.done))
                      ]
                    : [
                        IconButton(
                            splashRadius: 20,
                            onPressed: () {},
                            icon: const Icon(Icons.title)),
                        IconButton(
                            splashRadius: 20,
                            onPressed: () {},
                            icon: const Icon(Icons.star_outline)),
                        PopupMenuButton(
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                      child: Row(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(right: 4),
                                        child: Icon(Icons.search),
                                      ),
                                      Text('Search'),
                                    ],
                                  )),
                                  PopupMenuItem(
                                      onTap: () {
                                        controller.changeTitle.value = true;
                                      },
                                      child: Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(right: 4),
                                            child: Icon(Icons.edit_outlined),
                                          ),
                                          Text('Rename chat')
                                        ],
                                      )),
                                  PopupMenuItem(
                                      value: 2,
                                      child: Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(right: 8),
                                            child: Icon(Icons.cloud_outlined),
                                          ),
                                          Text('Media')
                                        ],
                                      )),
                                  PopupMenuItem(
                                      onTap: () {
                                        controller.showDate.value =
                                            !controller.showDate.value;
                                      },
                                      child: Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(right: 8),
                                            child:
                                                Icon(Icons.date_range_outlined),
                                          ),
                                          Text('Show date')
                                        ],
                                      )),
                                  PopupMenuItem(
                                      onTap: () {
                                        // pickImage();
                                      },
                                      child: Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(right: 8),
                                            child: Icon(Icons.palette_outlined),
                                          ),
                                          Text('Change background')
                                        ],
                                      )),
                                ])
                      ],
                title: controller.changeTitle.value
                    ? TitleWidget(
                        controller: titleController,
                        change: controller.changeTitle,
                        focusNode: titleFocus)
                    : Text(titleController.text)),
            body: ChatBody(chat: homeItem.child),
            bottomNavigationBar: ChatBottomAppBar(homeItem: homeItem),
          )),
    );
  }
}
