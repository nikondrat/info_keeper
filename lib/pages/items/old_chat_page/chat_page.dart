import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/old_chat.dart';
import 'package:info_keeper/pages/items/old_chat_page/chat_favorites_page.dart';
import 'package:info_keeper/pages/items/old_chat_page/chat_media.dart';
import 'package:info_keeper/pages/items/old_chat_page/chat_search.dart';
import 'package:info_keeper/pages/items/old_chat_page/chat_titles_page.dart';
import 'package:info_keeper/pages/items/old_chat_page/chat_vault_page.dart';
import 'package:info_keeper/pages/items/old_chat_page/widgets/chat_bottom_text_field.dart';
import 'package:info_keeper/pages/items/old_chat_page/widgets/chat_pinned_message.dart';
import 'package:info_keeper/pages/items/old_chat_page/widgets/chat_body.dart';
import 'package:info_keeper/pages/items/old_chat_page/widgets/chat_title.dart';
import 'package:info_keeper/pages/items/old_chat_page/widgets/message_menu/chat_colors_selector.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:swipe/swipe.dart';

class OldChatPage extends StatelessWidget {
  final int chatIndex;
  final int? messageIndex;
  const OldChatPage({Key? key, this.messageIndex, required this.chatIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final renameChat = false.obs;
    final selectedMessage = 0.obs;
    final isShowColorSelector = false.obs;
    final showDate = false.obs;
    final editMessage = false.obs;
    final moveMessage = false.obs;

    final splitMessages = false.obs;
    final selectedMessagesCount = 0.obs;

    final selectedMessages = [].obs;

    final RxList pinnedMessages = Controller
        .to
        .all[Controller.to.selectedFolder.value]
        .childrens[Controller.to.selectedElementIndex.value]
        .child
        .value
        .pinnedMessages;
    final pathToImage = ''.obs;

    if (Controller
        .to
        .all[Controller.to.selectedFolder.value]
        .childrens[Controller.to.selectedElementIndex.value]
        .child
        .value
        .pathToImage
        .isNotEmpty) {
      pathToImage.value = Controller
          .to
          .all[Controller.to.selectedFolder.value]
          .childrens[Controller.to.selectedElementIndex.value]
          .child
          .value
          .pathToImage;
    }

    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();
    AutoScrollController autoScrollController = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: Axis.vertical,
    );
    FocusNode textFieldFocusNode = FocusNode();

    if (messageIndex != null) {
      autoScrollController.scrollToIndex(messageIndex!);
    }
    void pickImage() async {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        Directory dir = await getApplicationDocumentsDirectory();
        File file = File(result.files.single.path.toString());
        String path = '${dir.path}/${result.files.single.name}';
        await file.copy(path);
        pathToImage.value = path;
        Controller.to.change(
          ChatItem(pathToImage: pathToImage.value),
        );
      }
    }

    return Obx(
      () => Swipe(
        onSwipeRight: () => Get.to(() => const ChatPageVault()),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                centerTitle: false,
                actions: selectedMessagesCount.value >= 2
                    ? [
                        IconButton(
                            onPressed: () {
                              for (int i = 1;
                                  i < selectedMessages.length;
                                  i++) {
                                selectedMessages[0].messageText =
                                    '${selectedMessages[0].messageText}\n${selectedMessages[i].messageText}';

                                List messages = Controller
                                    .to
                                    .all[Controller.to.selectedFolder.value]
                                    .childrens[Controller
                                        .to.selectedElementIndex.value]
                                    .child
                                    .value
                                    .messages;

                                messages.remove(selectedMessages[i]);
                                Controller.to
                                    .change(ChatItem(messages: messages.obs));
                              }
                              selectedMessagesCount.value = 0;
                              splitMessages.value = false;
                            },
                            icon: const Icon(Icons.forum_outlined),
                            splashRadius: 20)
                      ]
                    : [
                        IconButton(
                            onPressed: () => Get.to(() => ChatPageTitles(
                                autoScrollController: autoScrollController,
                                splitMessages: splitMessages)),
                            icon: const Icon(Icons.title),
                            splashRadius: 20),
                        IconButton(
                          onPressed: () => Get.to(() => ChatPageFavorites(
                                autoScrollController: autoScrollController,
                                splitMessages: splitMessages,
                              )),
                          icon: const Icon(Icons.star_outline),
                          splashRadius: 20,
                        ),
                        PopupMenuButton(
                            splashRadius: 20,
                            onSelected: (value) {
                              if (value == 0) {
                                Get.to(() => const ChatPageSearch());
                              }
                              if (value == 2) {
                                Get.to(() => ChatPageMedia(index: chatIndex));
                              }
                            },
                            tooltip: '',
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                      value: 0,
                                      child: Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(right: 8),
                                            child: Icon(Icons.search),
                                          ),
                                          Text('Search')
                                        ],
                                      )),
                                  PopupMenuItem(
                                      onTap: () {
                                        renameChat.value = true;
                                      },
                                      child: Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(right: 8),
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
                                        showDate.value = !showDate.value;
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
                                        pickImage();
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
                leading: splitMessages.value
                    ? IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          splitMessages.value = false;
                          selectedMessagesCount.value = 0;
                          for (int i = 0; i < selectedMessages.length; i++) {
                            selectedMessages[i].isSelected =
                                !selectedMessages[i].isSelected;
                          }
                          selectedMessages.clear();
                        },
                        icon: const Icon(Icons.close))
                    : IconButton(
                        splashRadius: 20,
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Get.back(),
                      ),
                title: ChatPageTitle(
                  renameChat: renameChat,
                  index: chatIndex,
                ),
                bottom: pinnedMessages.isNotEmpty
                    ? PreferredSize(
                        preferredSize: const Size.fromHeight(48),
                        child: ChatPagePinnedMessage(
                          pinnedMessages: pinnedMessages,
                          autoScrollController: autoScrollController,
                        ))
                    : null),
            body: pathToImage.isNotEmpty
                ? Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(File(pathToImage.value)),
                            fit: BoxFit.cover)),
                    child: ChatPageBody(
                      moveMessage: moveMessage,
                      pinnedMessages: pinnedMessages,
                      selectedMessages: selectedMessages,
                      selectedMessageCount: selectedMessagesCount,
                      autoScrollController: autoScrollController,
                      splitMessages: splitMessages,
                      titleController: titleController,
                      contentController: contentController,
                      editMessage: editMessage,
                      textFieldFocusNode: textFieldFocusNode,
                      isShowColorSelector: isShowColorSelector,
                      showDate: showDate,
                      selectedMessage: selectedMessage,
                    ),
                  )
                : ChatPageBody(
                    moveMessage: moveMessage,
                    pinnedMessages: pinnedMessages,
                    selectedMessages: selectedMessages,
                    selectedMessageCount: selectedMessagesCount,
                    autoScrollController: autoScrollController,
                    splitMessages: splitMessages,
                    titleController: titleController,
                    contentController: contentController,
                    editMessage: editMessage,
                    textFieldFocusNode: textFieldFocusNode,
                    isShowColorSelector: isShowColorSelector,
                    showDate: showDate,
                    selectedMessage: selectedMessage,
                  ),
            bottomNavigationBar: isShowColorSelector.value
                ? ChatPageColorSelector(
                    selectedMessage: selectedMessage,
                    messageColorValue: Controller
                        .to
                        .all[Controller.to.selectedFolder.value]
                        .childrens[Controller.to.selectedElementIndex.value]
                        .child
                        .value
                        .messages![selectedMessage.value]
                        .selectedColorIndex,
                    isShowColorSelector: isShowColorSelector)
                : ChatPageBottomTextField(
                    editMessage: editMessage,
                    focusNode: textFieldFocusNode,
                    selectedMessage: selectedMessage,
                    titleController: titleController,
                    contentController: contentController)),
      ),
    );
  }
}
