import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:info_keeper/theme.dart';
import 'package:intl/intl.dart';

class ChatVoiceWidget extends StatefulWidget {
  final String path;
  final String dateTime;
  final RxBool showDate;
  const ChatVoiceWidget(
      {Key? key,
      required this.path,
      required this.dateTime,
      required this.showDate})
      : super(key: key);

  @override
  State<ChatVoiceWidget> createState() => _ChatVoiceWidgetState();
}

class _ChatVoiceWidgetState extends State<ChatVoiceWidget> {
  FlutterSoundPlayer? mPlayer = FlutterSoundPlayer();
  final isPlay = false.obs;
  late DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
  late DateTime time = format.parse(widget.dateTime);

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
        fromURI: widget.path,
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
    body() {
      return Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: messageColors[5],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              Obx(() => isPlay.value
                  ? IconButton(
                      onPressed: stop,
                      icon: const Icon(Icons.pause),
                      splashRadius: 20)
                  : IconButton(
                      icon: const Icon(Icons.play_arrow),
                      onPressed: play,
                      splashRadius: 20,
                    )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.showDate.value
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            '${time.hour}:${time.minute}',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        )
                      : Container(),
                ],
              )
            ],
          ));
    }

    return body();
  }
}
