import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/items/chat/pages/media/body/files.dart';
import 'package:info_keeper/pages/items/chat/pages/media/body/links.dart';
import 'package:info_keeper/pages/items/chat/pages/media/body/media.dart';
import 'package:info_keeper/pages/items/chat/pages/media/body/sounds.dart';

class ChatMediaPage extends StatefulWidget {
  final HomeItem homeItem;
  const ChatMediaPage({super.key, required this.homeItem});

  @override
  State<ChatMediaPage> createState() => _ChatMediaPageState();
}

class _ChatMediaPageState extends State<ChatMediaPage>
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
          title: Text(widget.homeItem.name),
          leading: IconButton(
            splashRadius: 20,
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back),
          ),
          bottom: TabBar(
              controller: tabController,
              physics: const NeverScrollableScrollPhysics(),
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black,
              indicatorColor: Colors.black54,
              tabs: const [
                Tab(text: 'Media'),
                Tab(text: 'Files'),
                Tab(text: 'Links'),
                Tab(text: 'Sounds'),
              ])),
      body: TabBarView(
          physics: const BouncingScrollPhysics(),
          controller: tabController,
          children: [
            ChatMediaBody(chat: widget.homeItem.child),
            ChatMediaFiles(chat: widget.homeItem.child),
            ChatMediaLinks(chat: widget.homeItem.child),
            ChatMediaSounds(chat: widget.homeItem.child)
          ]),
    );
  }
}
