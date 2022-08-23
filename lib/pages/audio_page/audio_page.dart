import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/audio/audio_note.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/item_location.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({Key? key}) : super(key: key);

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  Codec codec = Codec.aacMP4;
  DateFormat dateFormat = DateFormat("yyyy_MM_dd_HH_mm_ss");
  String mPath = '';
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer player = FlutterSoundPlayer();
  TextEditingController titleController = TextEditingController();
  final isRecord = false.obs;
  // List decibels = [];

  @override
  void dispose() {
    recorder.closeRecorder();
    titleController.dispose();

    super.dispose();
  }

  Future<void> openTheRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    mPath = '${dateFormat.format(DateTime.now())}.mp4';
    return record();
  }
  // ----------------------  Here is the code for recording and playback -------

  void record() async {
    if (recorder.isPaused) {
      recorder.resumeRecorder();
    } else {
      await recorder.openRecorder().then((value) {
        recorder.startRecorder(
          toFile: mPath,
          codec: codec,
        );
        // recorder.setSubscriptionDuration(Duration(seconds: 20));
        // value!.onProgress!.listen((event) {
        //   print(event.decibels);
        // }).onData((data) {
        //   decibels.add(data.decibels);
        // });
      });
    }
    isRecord.value = true;
  }

  void stopRecorder() {
    recorder.stopRecorder();
    isRecord.value = false;
    // print(decibels);
  }

  void closeRecorder() {
    recorder.closeRecorder();
    Controller.to.add(HomeItem(
        name: titleController.text,
        child: AudioNote(
          path: mPath,
        ),
        location: ItemLocation(
            inDirectory: Controller.to.selectedFolder.value,
            index: Controller
                .to.all[Controller.to.selectedFolder.value].childrens.length)));
    Get.back();
  }

// ----------------------------- UI --------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: TextField(
          controller: titleController,
          autofocus: true,
          cursorColor: Colors.black,
          decoration: InputDecoration(
              hintText: 'Write title',
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.red)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide()),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide()),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide()),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(),
              )),
        ),
        leading: IconButton(
            splashRadius: 20,
            onPressed: () {
              Get.back();
              closeRecorder();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        double size = 0.14;
        double width = constraints.maxWidth * size;
        double height = constraints.maxHeight * size;

        return ListView(padding: const EdgeInsets.all(20), children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(() => isRecord.value
                  ? GestureDetector(
                      onTap: stopRecorder,
                      child: Container(
                        width: width,
                        height: height,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                        child: Icon(
                          Icons.pause,
                          color: Colors.white,
                          size: height * 0.3,
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: openTheRecorder,
                      child: Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.red, width: width * 0.3),
                            shape: BoxShape.circle,
                            color: Colors.white),
                      ),
                    )),
              GestureDetector(
                onTap: closeRecorder,
                child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey.shade300),
                  child: Icon(
                    Icons.done,
                    color: Colors.grey.shade800,
                    size: height * 0.3,
                  ),
                ),
              )
            ],
          )
        ]);
      }),
      // body: Column(children: [
      //   TextButton(onPressed: record, child: const Text('Start')),
      //   TextButton(onPressed: stopRecorder, child: const Text('Stop')),
      //   TextButton(onPressed: play, child: const Text('play'))
      // ]),
    );
  }
}
