import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/items/voice.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/items/item_decoration.dart';

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

    void play() async {
      await player.openPlayer().then((value) {
        player.startPlayer(
            codec: voice.codec,
            fromURI: voice.path,
            whenFinished: () {
              voice.isPlay = false;
              voice.copyWith(isPlay: voice.isPlay);
              Controller.to.setData();
              player.closePlayer();
            });
        voice.isPlay = true;
        voice.copyWith(isPlay: voice.isPlay);
        Controller.to.setData();
      });
    }

    void close() {
      player.closePlayer();
      voice.isPlay = false;
      voice.copyWith(isPlay: voice.isPlay);
      Controller.to.setData();
    }

    return ItemDecoration(
        dateTime: voice.dateTime,
        elevation: elevation,
        child: Row(
          children: [
            IconButton(
                splashRadius: 20,
                onPressed: voice.isPlay ? close : play,
                icon: Icon(voice.isPlay ? Icons.pause : Icons.play_arrow)),
            AutoSizeText(voice.name)
          ],
        ));
  }
}
