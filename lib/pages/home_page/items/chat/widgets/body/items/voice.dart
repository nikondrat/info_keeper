import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/chat/items/voice.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/item_decoration.dart';

class ChatVoiceWidget extends StatelessWidget {
  final ChatVoice voice;
  final double elevation;
  const ChatVoiceWidget({
    Key? key,
    required this.voice,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterSoundPlayer player = FlutterSoundPlayer();
    final isPlay = false.obs;

    void close() async {
      await player.closePlayer();
      isPlay.value = false;
    }

    void play() async {
      await player.openPlayer().then((value) {
        player.startPlayer(
            codec: voice.codec,
            fromURI: voice.path,
            whenFinished: () {
              isPlay.value = false;
              player.closePlayer();
            });
        isPlay.value = true;
      });
    }

    return ItemDecoration(
        index: voice.location.itemIndex!,
        dateTime: voice.dateTime,
        elevation: elevation,
        child: Row(
          children: [
            Obx(
              () => IconButton(
                  splashRadius: 20,
                  onPressed: isPlay.value ? close : play,
                  icon: Icon(isPlay.value ? Icons.pause : Icons.play_arrow)),
            ),
            Expanded(child: AutoSizeText(voice.name))
          ],
        ));
  }
}
