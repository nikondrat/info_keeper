import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/items/voice.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/item_location.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatBottomRecorder extends StatefulWidget {
  final HomeItem homeItem;
  const ChatBottomRecorder({Key? key, required this.homeItem})
      : super(key: key);

  @override
  State<ChatBottomRecorder> createState() => _ChatBottomRecorderState();
}

class _ChatBottomRecorderState extends State<ChatBottomRecorder> {
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  final DateFormat dateFormat = DateFormat("yyyy_MM_dd_HH_mm_ss");
  final Codec codec = Codec.aacADTS;
  String path = '';
  final RxBool isRecord = false.obs;

  Future<void> openTheRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await recorder.openRecorder().whenComplete(() => record());
  }

  void closeRecorder() {
    recorder.closeRecorder();
    isRecord.value = false;

    Chat chat = widget.homeItem.child;

    RxList messages = chat.messages;
    messages.insert(
        0,
        ChatVoice(
            path: path,
            location: ItemLocation(
                inDirectory: widget.homeItem.location.inDirectory,
                index: widget.homeItem.location.index,
                itemIndex: messages.length),
            dateTime: DateTime.now()));
    chat.copyWith(messages: messages);
    Controller.to.setData();
  }

  void record() {
    path = '${dateFormat.format(DateTime.now())}.aac';
    recorder.startRecorder(toFile: path, codec: codec);
    isRecord.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => IconButton(
        splashRadius: 20,
        onPressed: isRecord.value ? closeRecorder : openTheRecorder,
        icon: isRecord.value
            ? const Icon(Icons.radio_button_checked, color: Colors.red)
            : const Icon(Icons.mic)));
  }
}
