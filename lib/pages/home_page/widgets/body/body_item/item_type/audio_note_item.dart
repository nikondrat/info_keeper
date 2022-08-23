import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item_child_body.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item_decoration.dart';
import 'package:info_keeper/pages/home_page/widgets/body/body_item/body_item_gesture.dart';

class AudioNoteItem extends StatelessWidget {
  final int homeItemIndex;
  final HomeItem homeItem;
  final String term;
  const AudioNoteItem(
      {Key? key,
      required this.homeItemIndex,
      required this.homeItem,
      required this.term})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeBodyItemGesture(
      homeItemIndex: homeItemIndex,
      homeItem: homeItem,
      child: BodyItemDecoration(
        homeItem: homeItem,
        child: HomeBodyItemChildBody(
          homeItem: homeItem,
          term: term,
          horizontalChild: AudioNoteItemBody(homeItem: homeItem),
        ),
      ),
    );
  }
}

class AudioNoteItemBody extends StatefulWidget {
  final HomeItem homeItem;
  const AudioNoteItemBody({Key? key, required this.homeItem}) : super(key: key);

  @override
  State<AudioNoteItemBody> createState() => _AudioNoteItemBodyState();
}

class _AudioNoteItemBodyState extends State<AudioNoteItemBody> {
  late final FlutterSoundPlayer player;
  final isPlay = false.obs;

  @override
  void dispose() {
    player.closePlayer();
    super.dispose();
  }

  void play() async {
    player = FlutterSoundPlayer();
    await player.openPlayer().whenComplete(() {
      isPlay.value = true;
      player.startPlayer(
          codec: widget.homeItem.child.codec,
          fromURI: widget.homeItem.child.path,
          whenFinished: () {
            isPlay.value = false;
          });
    });
  }

  void stop() {
    isPlay.value = false;
    player.pausePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => IconButton(
        onPressed: isPlay.value ? stop : play,
        icon: Icon(isPlay.value ? Icons.pause : Icons.play_arrow),
        splashRadius: 20));
  }
}
