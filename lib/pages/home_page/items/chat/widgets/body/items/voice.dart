import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/items/voice.dart';
import 'package:info_keeper/model/types/trash/trash_item.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_controller.dart';
import 'package:info_keeper/pages/home_page/items/chat/widgets/body/items/widgets/item_decoration.dart';

class ChatVoiceWidget extends StatefulWidget {
  final ChatVoice voice;
  final double elevation;
  final bool isTrash;
  const ChatVoiceWidget({
    Key? key,
    required this.voice,
    this.elevation = 0,
    this.isTrash = false,
  }) : super(key: key);

  @override
  State<ChatVoiceWidget> createState() => _ChatVoiceWidgetState();
}

class _ChatVoiceWidgetState extends State<ChatVoiceWidget> {
  FlutterSoundPlayer player = FlutterSoundPlayer();
  bool isPlay = false;

  void close() async {
    await player.closePlayer();
    setState(() {
      isPlay = false;
    });
  }

  void play() async {
    await player.openPlayer().then((value) {
      player.startPlayer(
          codec: widget.voice.codec,
          fromURI: widget.voice.path,
          whenFinished: () {
            setState(() {
              isPlay = false;
              player.closePlayer();
            });
          });
      setState(() {
        isPlay = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ItemDecoration(
        index: widget.voice.location.itemIndex!,
        dateTime: widget.voice.dateTime,
        elevation: widget.elevation,
        isTrash: widget.isTrash,
        child: Row(children: [
          isPlay
              ? IconButton(
                  splashRadius: 20,
                  onPressed: close,
                  icon: Icon(Icons.pause,
                      color: Theme.of(context).textTheme.bodyText1!.color))
              : IconButton(
                  splashRadius: 20,
                  onPressed: play,
                  icon: Icon(Icons.play_arrow,
                      color: Theme.of(context).textTheme.bodyText1!.color)),
          Expanded(
              child: AutoSizeText(widget.voice.name,
                  style: Theme.of(context).textTheme.bodyText1)),
          IconButton(
              onPressed: () {
                final ChatController chatController = Get.find();

                final Chat chat = chatController.homeItem.child;
                RxList messages = chat.messages;
                Controller.to.trashElements
                    .add(TrashItem(child: widget.voice, isMessage: true));
                messages.removeAt(messages.indexOf(widget.voice));
              },
              icon: Icon(Icons.delete,
                  color: Theme.of(context).textTheme.bodyText1!.color),
              splashRadius: 20)
        ]));
  }
}
