import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatBottomRecorder extends StatefulWidget {
  const ChatBottomRecorder({Key? key}) : super(key: key);

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
    await recorder.openRecorder().whenComplete(() => record);
  }

  void closeRecorder() {}

  void record() {
    path = '${dateFormat.format(DateTime.now())}.aac';
    recorder.startRecorder(toFile: path, codec: codec);
    isRecord.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => IconButton(
        splashRadius: 20,
        onPressed: () {},
        icon: isRecord.value
            ? const Icon(Icons.radio_button_checked, color: Colors.red)
            : const Icon(Icons.mic)));
  }
}
