import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/pages/trash_page/trash_element.dart';
import 'package:info_keeper/themes/default/default.dart';
import 'package:intl/intl.dart';

class ChatVoiceWidget extends StatefulWidget {
  final int? index;
  final String name;
  final String path;
  final String dateTime;
  final RxBool showDate;
  final Codec codec;
  final RxBool? moveMessage;
  final bool isTrash;
  const ChatVoiceWidget(
      {Key? key,
      this.index,
      required this.name,
      required this.path,
      required this.dateTime,
      this.moveMessage,
      required this.codec,
      this.isTrash = false,
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
  final isShowRestoreMenu = false.obs;

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
        codec: widget.codec,
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
    return TrashElement(
        isShowRestoreMenu: isShowRestoreMenu,
        isMessage: true,
        index: widget.index,
        child: GestureDetector(
          onLongPress:
              widget.isTrash ? () => isShowRestoreMenu.value = true : null,
          onTap: widget.moveMessage != null
              ? widget.moveMessage!.value && !widget.isTrash
                  ? () {
                      var message = Controller
                          .to
                          .all[Controller.to.selectedFolder.value]
                          .childrens[Controller.to.selectedElementIndex.value]
                          .child
                          .value
                          .messages
                          .removeAt(Controller.to.firstSelectedMessage);
                      Controller
                          .to
                          .all[Controller.to.selectedFolder.value]
                          .childrens[Controller.to.selectedElementIndex.value]
                          .child
                          .value
                          .messages
                          .insert(widget.index, message);
                      widget.moveMessage!.value = false;
                    }
                  : null
              : null,
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                color: messageColors[5],
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => IconButton(
                          onPressed: isPlay.value ? stop : play,
                          icon: Icon(
                              isPlay.value ? Icons.pause : Icons.play_arrow),
                          splashRadius: 20)),
                      widget.name.isNotEmpty
                          ? Expanded(child: Text(widget.name))
                          : const SizedBox(),
                      widget.isTrash
                          ? const SizedBox()
                          : IconButton(
                              splashRadius: 20,
                              onPressed: () {
                                var message = Controller
                                    .to
                                    .all[Controller.to.selectedFolder.value]
                                    .childrens[Controller
                                        .to.selectedElementIndex.value]
                                    .child
                                    .value
                                    .messages
                                    .removeAt(widget.index);

                                Controller.to.trashElements.add(message);
                                Controller.to.setData();
                              },
                              icon: const Icon(Icons.delete))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      widget.showDate.value
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8, right: 8),
                              child: Text(
                                '${time.hour}:${time.minute}',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            )
                          : Container(),
                    ],
                  )
                ],
              )),
        ));
  }
}
