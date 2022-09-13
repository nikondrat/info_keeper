import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';
import 'package:info_keeper/pages/trash_page/trash_element.dart';

class HomeWidgetAudioNote extends StatelessWidget {
  final HomeItem homeItem;
  final String term;
  final int index;
  final bool? isTrash;
  const HomeWidgetAudioNote(
      {Key? key,
      required this.homeItem,
      required this.index,
      this.term = '',
      this.isTrash})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isShowRestoreMenu = false.obs;
    late final HomeController home = Get.find();

    return GestureDetector(
        onLongPress: isTrash != null
            ? () => isShowRestoreMenu.value = true
            : () {
                home.isShowBottomMenu.value = true;
                Controller.to.selectedElementIndex.value = index;
              },
        child: TrashElement(
            isShowRestoreMenu: isShowRestoreMenu,
            index: index,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: homeItem.isAnimated
                            ? const Color(0xFFB9DFBB)
                            : Colors.grey.shade600,
                        width: homeItem.isAnimated ? 1.4 : 1)),
                child: Row(children: [
                  homeItem.isPinned
                      ? const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(Icons.push_pin_outlined),
                        )
                      : Container(),
                  homeItem.isDublicated
                      ? const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(Icons.copy_all))
                      : Container(),
                  HomeWidgetAudioNoteBody(homeItem: homeItem),
                  // Expanded(
                  //     child: SubstringHighlight(
                  //   text: homeItem.name,
                  //   term: term,
                  //   textStyle: const TextStyle(
                  //       fontWeight: FontWeight.bold, color: Colors.black),
                  // ))
                ]))));
  }
}

class HomeWidgetAudioNoteBody extends StatefulWidget {
  final HomeItem homeItem;
  const HomeWidgetAudioNoteBody({Key? key, required this.homeItem})
      : super(key: key);

  @override
  State<HomeWidgetAudioNoteBody> createState() =>
      _HomeWidgetAudioNoteBodyState();
}

class _HomeWidgetAudioNoteBodyState extends State<HomeWidgetAudioNoteBody> {
  FlutterSoundPlayer? mPlayer = FlutterSoundPlayer();
  final isPlay = false.obs;

  @override
  void initState() {
    mPlayer!.openPlayer();
    super.initState();
  }

  @override
  void dispose() {
    mPlayer!.closePlayer();
    mPlayer = null;
    super.dispose();
  }

  void play() {
    isPlay.value = true;
    mPlayer!.startPlayer(
        codec: Codec.aacMP4,
        fromURI: widget.homeItem.child.value.path,
        whenFinished: () {
          isPlay.value = false;
        });
  }

  void stop() {
    isPlay.value = false;
    mPlayer!.stopPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => isPlay.value
        ? IconButton(
            onPressed: stop, icon: const Icon(Icons.pause), splashRadius: 20)
        : IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: play,
            splashRadius: 20,
          ));
  }
}
