import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';

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
              .directoryChildrens[widget.index].name,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
          splashRadius: 20,
        ),
        bottom: TabBar(
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
      body: TabBarView(controller: tabController, children: const [
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
    return const Text('images');
  }
}

class ChatMediaBodyFiles extends StatelessWidget {
  const ChatMediaBodyFiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('files');
  }
}

class ChatMediaBodyLinks extends StatelessWidget {
  const ChatMediaBodyLinks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('links');
  }
}

class ChatMediaBodySounds extends StatelessWidget {
  const ChatMediaBodySounds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('sounds');
  }
}
