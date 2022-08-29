import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/pages/items/old_chat_page/widgets/type/chat_file.dart';
import 'package:info_keeper/pages/items/old_chat_page/widgets/type/chat_message.dart';
import 'package:info_keeper/pages/items/old_chat_page/widgets/type/chat_voice.dart';

class ChatPageMedia extends StatefulWidget {
  final int index;
  const ChatPageMedia({Key? key, required this.index}) : super(key: key);

  @override
  State<ChatPageMedia> createState() => _ChatPageMediaState();
}

class _ChatPageMediaState extends State<ChatPageMedia>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          Controller.to.all[Controller.to.selectedFolder.value]
              .childrens[widget.index].name,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
          splashRadius: 20,
        ),
        bottom: TabBar(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            indicatorColor: Colors.black54,
            tabs: const [
              Tab(text: 'Media'),
              Tab(text: 'Files'),
              Tab(text: 'Links'),
              Tab(text: 'Sounds'),
            ]),
      ),
      body: TabBarView(
          physics: const BouncingScrollPhysics(),
          controller: tabController,
          children: const [
            ChatMediaBodyImages(),
            ChatMediaBodyFiles(),
            ChatMediaBodyLinks(),
            ChatMediaBodySounds()
          ]),
    );
  }
}

class ChatMediaBodyImages extends StatelessWidget {
  const ChatMediaBodyImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List images = [];

    for (int i = 0;
        i <
            Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value]
                .child
                .value
                .messages
                .length;
        i++) {
      if (Controller
              .to
              .all[Controller.to.selectedFolder.value]
              .childrens[Controller.to.selectedElementIndex.value]
              .child
              .value
              .messages[i]
              .type ==
          AllType.chatImage) {
        images.add(Controller
            .to
            .all[Controller.to.selectedFolder.value]
            .childrens[Controller.to.selectedElementIndex.value]
            .child
            .value
            .messages[i]);
      }
    }

    return GridView.builder(
      itemCount: images.length,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150, crossAxisSpacing: 4, mainAxisSpacing: 4),
      itemBuilder: (context, index) => Image(
        fit: BoxFit.cover,
        image: FileImage(File(images[index].path)),
      ),
    );
  }
}

class ChatMediaBodyFiles extends StatelessWidget {
  const ChatMediaBodyFiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List files = [];

    for (int i = 0;
        i <
            Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value]
                .child
                .value
                .messages
                .length;
        i++) {
      if (Controller
              .to
              .all[Controller.to.selectedFolder.value]
              .childrens[Controller.to.selectedElementIndex.value]
              .child
              .value
              .messages[i]
              .type ==
          AllType.chatFile) {
        files.add(Controller
            .to
            .all[Controller.to.selectedFolder.value]
            .childrens[Controller.to.selectedElementIndex.value]
            .child
            .value
            .messages[i]);
      }
    }
    return ListView.builder(
        itemCount: files.length,
        padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, i) => ChatPageFile(
            name: files[i].name,
            path: files[i].path,
            dateTime: files[i].dateTime,
            showDate: false.obs));
  }
}

class ChatMediaBodyLinks extends StatelessWidget {
  const ChatMediaBodyLinks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List links = [];

    for (int i = 0;
        i <
            Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value]
                .child
                .value
                .messages
                .length;
        i++) {
      if (Controller
                  .to
                  .all[Controller.to.selectedFolder.value]
                  .childrens[Controller.to.selectedElementIndex.value]
                  .child
                  .value
                  .messages[i]
                  .type ==
              AllType.chatMessage &&
          !Controller
              .to
              .all[Controller.to.selectedFolder.value]
              .childrens[Controller.to.selectedElementIndex.value]
              .child
              .value
              .messages[i]
              .isLocked &&
          Controller
              .to
              .all[Controller.to.selectedFolder.value]
              .childrens[Controller.to.selectedElementIndex.value]
              .child
              .value
              .messages[i]
              .content
              .contains(RegExp(r'(https?://[^\s]+)'))) {
        links.add(Controller
            .to
            .all[Controller.to.selectedFolder.value]
            .childrens[Controller.to.selectedElementIndex.value]
            .child
            .value
            .messages[i]);
      }
    }

    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        itemCount: links.length,
        itemBuilder: (context, i) => MessageWidgetBody(
              message: links[i],
              dateTime: links[i].dateTime,
            ));
  }
}

class ChatMediaBodySounds extends StatelessWidget {
  const ChatMediaBodySounds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List sounds = [];

    for (int i = 0;
        i <
            Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .childrens[Controller.to.selectedElementIndex.value]
                .child
                .value
                .messages
                .length;
        i++) {
      if (Controller
              .to
              .all[Controller.to.selectedFolder.value]
              .childrens[Controller.to.selectedElementIndex.value]
              .child
              .value
              .messages[i]
              .type ==
          AllType.chatVoice) {
        sounds.add(Controller
            .to
            .all[Controller.to.selectedFolder.value]
            .childrens[Controller.to.selectedElementIndex.value]
            .child
            .value
            .messages[i]);
      }
    }
    return ListView.builder(
        itemCount: sounds.length,
        padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, i) => ChatVoiceWidget(
            name: sounds[i].name,
            path: sounds[i].path,
            codec: sounds[i].codec,
            dateTime: sounds[i].dateTime,
            showDate: false.obs));
  }
}
