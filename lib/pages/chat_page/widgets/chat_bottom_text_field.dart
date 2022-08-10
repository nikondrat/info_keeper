import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/chat/chat.dart';
import 'package:info_keeper/model/types/chat/chat_image.dart';
import 'package:info_keeper/model/types/chat/message.dart';
import 'package:info_keeper/model/types/location_element.dart';
import 'package:info_keeper/pages/chat_page/widgets/chat_record_voice.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class ChatPageBottomTextField extends StatelessWidget {
  final RxBool editMessage;
  final TextEditingController titleController;
  final TextEditingController contentController;
  final RxInt selectedMessage;
  final FocusNode focusNode;
  const ChatPageBottomTextField(
      {Key? key,
      required this.editMessage,
      required this.selectedMessage,
      required this.titleController,
      required this.focusNode,
      required this.contentController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textFieldIsEmpty = true.obs;
    final isShowTitleTextField = false.obs;
    DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
    String dateTime = format.format(DateTime.now());

    void pickImage() async {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        Directory dir = await getApplicationDocumentsDirectory();
        File file = File(result.files.single.path.toString());
        String path = '${dir.path}/${result.files.single.name}';
        await file.copy(path);
        Controller.to.addChatImage(ChatImage(
            path: path,
            dateTime: dateTime,
            location: LocationElement(
                inDirectory: Controller.to.selectedFolder.value,
                index: Controller.to.selectedElementIndex.value,
                selectedMessageIndex: Controller
                    .to
                    .all[Controller.to.selectedFolder.value]
                    .directoryChildrens[
                        Controller.to.selectedElementIndex.value]
                    .messages
                    .length)));
      }
    }

    return Transform.translate(
        offset: Offset(0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: LayoutBuilder(
          builder: (context, constraints) => BottomAppBar(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                  width: 1,
                  color: Colors.grey.shade300,
                ),
              )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => editMessage.value &&
                          Controller
                                  .to
                                  .all[Controller.to.selectedFolder.value]
                                  .directoryChildrens[
                                      Controller.to.selectedElementIndex.value]
                                  .messages![selectedMessage.value]
                                  .type ==
                              AllType.chatMessage
                      ? ListTile(
                          minVerticalPadding: 0,
                          visualDensity: VisualDensity.compact,
                          title: const Text('Edit'),
                          subtitle: Text(
                            Controller
                                .to
                                .all[Controller.to.selectedFolder.value]
                                .directoryChildrens[
                                    Controller.to.selectedElementIndex.value]
                                .messages![selectedMessage.value]
                                .messageText,
                            maxLines: 1,
                            textAlign: TextAlign.justify,
                          ),
                          style: ListTileStyle.drawer,
                          leading: const Icon(Icons.edit_outlined),
                          trailing: IconButton(
                              splashRadius: 20,
                              onPressed: () {
                                editMessage.value = false;
                                titleController.clear();
                                contentController.clear();
                                FocusScope.of(context).unfocus();
                                textFieldIsEmpty.value = true;
                              },
                              icon: const Icon(Icons.close)),
                        )
                      : Container()),
                  Obx(() => isShowTitleTextField.value
                      ? TextField(
                          controller: titleController,
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.send,
                          decoration: const InputDecoration(
                              hintText: 'Title',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              border: InputBorder.none),
                        )
                      : Container()),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => isShowTitleTextField.value =
                              !isShowTitleTextField.value,
                          splashRadius: 20,
                          icon: const Icon(Icons.title)),
                      Expanded(
                        child: Container(
                          constraints: BoxConstraints(
                              maxHeight: constraints.maxHeight * 0.14),
                          child: TextField(
                            controller: contentController,
                            autofocus: editMessage.value ? true : false,
                            maxLines: null,
                            focusNode: focusNode,
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                                hintText: 'Write text',
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                border: InputBorder.none),
                            onEditingComplete: () {
                              contentController.text.isEmpty
                                  ? textFieldIsEmpty.value = true
                                  : textFieldIsEmpty.value = false;
                            },
                            onChanged: (value) {
                              value.isEmpty
                                  ? textFieldIsEmpty.value = true
                                  : textFieldIsEmpty.value = false;
                            },
                          ),
                        ),
                      ),
                      Obx(
                        () => textFieldIsEmpty.value
                            ? (Platform.isAndroid || Platform.isIOS)
                                ? Row(
                                    children: [
                                      IconButton(
                                        onPressed: pickImage,
                                        icon: const Icon(Icons.attach_file),
                                        splashRadius: 20,
                                      ),
                                      const ChatPageRecordVoice()
                                    ],
                                  )
                                : Container()
                            : IconButton(
                                onPressed: () {
                                  if (editMessage.value &&
                                      Controller
                                              .to
                                              .all[Controller
                                                  .to.selectedFolder.value]
                                              .directoryChildrens[Controller.to
                                                  .selectedElementIndex.value]
                                              .messages![selectedMessage.value]
                                              .type ==
                                          AllType.chatMessage) {
                                    List messages = Controller
                                        .to
                                        .all[Controller.to.selectedFolder.value]
                                        .directoryChildrens[Controller
                                            .to.selectedElementIndex.value]
                                        .messages!;

                                    final List history = [];

                                    for (int i = 0;
                                        i <
                                            messages[selectedMessage.value]
                                                .history
                                                .length;
                                        i++) {
                                      history.add(
                                          messages[selectedMessage.value]
                                              .history[i]);
                                    }

                                    messages[selectedMessage.value].title =
                                        titleController.value.text;
                                    messages[selectedMessage.value]
                                            .messageText =
                                        contentController.value.text;
                                    history.add(messages[selectedMessage.value]
                                        .messageText);
                                    messages[selectedMessage.value].history =
                                        history;

                                    Controller.to
                                        .change(Chat(messages: messages.obs));
                                  } else {
                                    if (contentController.text.isNotEmpty) {
                                      List messages = Controller
                                          .to
                                          .all[Controller
                                              .to.selectedFolder.value]
                                          .directoryChildrens[Controller
                                              .to.selectedElementIndex.value]
                                          .messages!;
                                      Controller.to.addMessage(Message(
                                          location: LocationElement(
                                              inDirectory: Controller
                                                  .to.selectedFolder.value,
                                              index: Controller.to
                                                  .selectedElementIndex.value,
                                              selectedMessageIndex:
                                                  messages.length),
                                          title: titleController.text,
                                          messageText: contentController.text,
                                          history: [],
                                          dateTime: dateTime));
                                    }
                                  }
                                  titleController.clear();
                                  contentController.clear();
                                  editMessage.value = false;
                                  FocusScope.of(context).unfocus();
                                  textFieldIsEmpty.value = true;
                                },
                                icon: const Icon(Icons.send),
                                splashRadius: 20,
                              ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
