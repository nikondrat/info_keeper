import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/items/voice.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/item_location.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatBottomRecorder extends StatelessWidget {
  final HomeItem homeItem;
  const ChatBottomRecorder({Key? key, required this.homeItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FlutterSoundRecorder recorder = FlutterSoundRecorder();
    final DateFormat dateFormat = DateFormat("yyyy_MM_dd_HH_mm_ss");
    Codec codec = Codec.aacADTS;
    String path = '';
    final RxBool isRecord = false.obs;

    void record() {
      path = '${dateFormat.format(DateTime.now())}.aac';
      recorder.startRecorder(toFile: path, codec: codec);
      isRecord.value = true;
    }

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

      RxList messages = homeItem.child.messages;

      messages.add(ChatVoice(
          path: path,
          location: ItemLocation(
              inDirectory: homeItem.location.inDirectory,
              index: homeItem.location.index,
              itemIndex: messages.length),
          dateTime: DateTime.now()));
      homeItem.child.copyWith(messages: messages);
      Controller.to.setData();
    }

    return Obx(() => IconButton(
        splashRadius: 20,
        onPressed: isRecord.value ? closeRecorder : openTheRecorder,
        icon: isRecord.value
            ? const Icon(Icons.radio_button_checked, color: Colors.red)
            : const Icon(Icons.mic)));
  }
}
