import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/audio_note.dart';
import 'package:info_keeper/pages/trash_page/trash_element.dart';
import 'package:substring_highlight/substring_highlight.dart';

class HomeWidgetAudioNote extends StatelessWidget {
  final AudioNote audioNote;
  final String term;
  final int index;
  final bool? isTrash;
  const HomeWidgetAudioNote(
      {Key? key,
      required this.audioNote,
      required this.index,
      this.term = '',
      this.isTrash})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isShowRestoreMenu = false.obs;

    return GestureDetector(
        onLongPress: isTrash != null
            ? () => isShowRestoreMenu.value = true
            : () {
                Controller.to.isShowMenu.value = true;
                Controller.to.selectedElementIndex.value = index;
              },
        child: TrashElement(
            isShowRestoreMenu: isShowRestoreMenu,
            index: index,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: audioNote.animate
                            ? const Color(0xFFB9DFBB)
                            : Colors.grey.shade600,
                        width: audioNote.animate ? 1.4 : 1)),
                child: Row(children: [
                  audioNote.pinned
                      ? const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(Icons.push_pin_outlined),
                        )
                      : Container(),
                  audioNote.dublicated
                      ? const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(Icons.copy_all))
                      : Container(),
                  HomeWidgetAudioNoteBody(audioNote: audioNote),
                  Expanded(
                      child:
                          SubstringHighlight(text: audioNote.name!, term: term))
                ]))));
  }
}

class HomeWidgetAudioNoteBody extends StatefulWidget {
  final AudioNote audioNote;
  const HomeWidgetAudioNoteBody({Key? key, required this.audioNote})
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
        fromURI: widget.audioNote.path,
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
