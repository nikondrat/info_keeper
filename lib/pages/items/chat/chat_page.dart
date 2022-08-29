import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/body.dart';
import 'package:info_keeper/pages/items/chat/widgets/btm_app_bar/btm_app_bar.dart';
import 'package:info_keeper/widgets/title.dart';
import 'package:swipe/swipe.dart';

class ChatPage extends StatelessWidget {
  final HomeItem homeItem;
  const ChatPage({Key? key, required this.homeItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // title
    final RxBool changeTitle = false.obs;
    TextEditingController titleController =
        TextEditingController(text: homeItem.name);
    FocusNode titleFocus = FocusNode();

    // body
    final RxBool showDate = true.obs;

    return Swipe(
      onSwipeRight: () => null,
      child: Obx(() => Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                titleSpacing: changeTitle.value ? 0 : null,
                centerTitle: false,
                leading: IconButton(
                    splashRadius: 20,
                    icon: Icon(
                        changeTitle.value ? Icons.close : Icons.arrow_back),
                    onPressed: changeTitle.value
                        ? () {
                            changeTitle.value = !changeTitle.value;
                            titleFocus.unfocus();
                            titleController.text = homeItem.name;
                          }
                        : () => Get.back()),
                actions: changeTitle.value
                    ? [
                        IconButton(
                            splashRadius: 20,
                            onPressed: () {
                              if (titleController.text.isNotEmpty) {
                                changeTitle.value = !changeTitle.value;
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
                                        changeTitle.value = true;
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
                                        // showDate.value = !showDate.value;
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
                title: changeTitle.value
                    ? TitleWidget(
                        controller: titleController,
                        change: changeTitle,
                        focusNode: titleFocus)
                    : Text(titleController.text)),
            body: ChatBody(chat: homeItem.child, showDate: showDate),
            bottomNavigationBar: ChatBottomAppBar(homeItem: homeItem),
          )),
    );
  }
}
