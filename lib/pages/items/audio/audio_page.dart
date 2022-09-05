import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/audio/audio_note.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/item_location.dart';
import 'package:info_keeper/widgets/app_bar/app_bar.dart';
import 'package:info_keeper/widgets/app_bar/widgets/title.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({Key? key}) : super(key: key);

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  // title
  late TextEditingController titleController = TextEditingController();
  final changeTitle = false.obs;
  final FocusNode titleFocus = FocusNode();

  //
  Codec codec = Codec.aacADTS;
  DateFormat dateFormat = DateFormat("yyyy_MM_dd_HH_mm_ss");
  String mPath = '';

  FlutterSoundRecorder? recorder;
  final isRecord = false.obs;
  // List decibels = [];

  @override
  void dispose() {
    if (recorder != null) {
      recorder!.closeRecorder();
    }
    recorder = null;
    titleController.dispose();

    super.dispose();
  }

  Future<void> openTheRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    mPath = '${dateFormat.format(DateTime.now())}.aac';
    return record();
  }
  // ----------------------  Here is the code for recording and playback -------

  void record() async {
    recorder = FlutterSoundRecorder();
    if (recorder!.isPaused) {
      recorder!.resumeRecorder();
    } else {
      await recorder!.openRecorder().then((value) {
        recorder!.startRecorder(
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

  void pauseRecorder() {
    recorder!.pauseRecorder();
    isRecord.value = false;
    // print(decibels);
  }

  void closeRecorder() {
    if (recorder != null) {
      recorder!.closeRecorder();
      Controller.to.add(HomeItem(
          name: titleController.text,
          child: AudioNote(
            codec: codec,
            path: mPath,
          ),
          location: ItemLocation(
              inDirectory: Controller.to.selectedFolder.value,
              index: Controller.to.all[Controller.to.selectedFolder.value]
                  .childrens.length)));
      Get.back();
    }
  }

// ----------------------------- UI --------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBarWidget(
              controller: titleController,
              change: changeTitle,
              focus: titleFocus)),
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
                      onTap: pauseRecorder,
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
