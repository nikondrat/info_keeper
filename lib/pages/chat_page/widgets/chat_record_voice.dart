import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/chat/chat_voice.dart';
import 'package:info_keeper/model/types/location_element.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatPageRecordVoice extends StatefulWidget {
  const ChatPageRecordVoice({Key? key}) : super(key: key);

  @override
  State<ChatPageRecordVoice> createState() => _ChatPageRecordVoiceState();
}

class _ChatPageRecordVoiceState extends State<ChatPageRecordVoice> {
  final isRecord = false.obs;
  DateFormat dateFormat = DateFormat("yyyy_MM_dd_HH_mm_ss");
  String mPath = '';
  Codec codec = Codec.aacMP4;
  FlutterSoundRecorder? recorder = FlutterSoundRecorder();

  @override
  void initState() {
    openTheRecorder();
    mPath = '${dateFormat.format(DateTime.now())}.mp4';
    super.initState();
  }

  @override
  void dispose() {
    recorder!.closeRecorder();
    recorder = null;
    super.dispose();
  }

  void closeRecorder() {
    DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
    String dateTime = format.format(DateTime.now());
    isRecord.value = false;
    recorder!.stopRecorder();
    Controller.to.addChatVoice(ChatVoice(
        path: mPath,
        dateTime: dateTime,
        location: LocationElement(
            inDirectory: Controller.to.selectedFolder.value,
            index: Controller.to.selectedElementIndex.value,
            selectedMessageIndex: Controller
                .to
                .all[Controller.to.selectedFolder.value]
                .directoryChildrens[Controller.to.selectedElementIndex.value]
                .messages
                .length)));
  }

  Future<void> openTheRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await recorder!.openRecorder();
  }

  void record() {
    recorder!.startRecorder(
      toFile: mPath,
      codec: codec,
    );

    isRecord.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => IconButton(
        onPressed: isRecord.value ? closeRecorder : record,
        splashRadius: 20,
        icon: isRecord.value
            ? const Icon(Icons.radio_button_checked, color: Colors.red)
            : const Icon(Icons.mic)));
  }
}
