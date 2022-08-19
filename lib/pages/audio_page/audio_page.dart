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
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  TextEditingController titleController = TextEditingController();
  final isRecord = false.obs;

  @override
  void initState() {
    openTheRecorder();
    mPath = '${dateFormat.format(DateTime.now())}.mp4';

    _mPlayer!.openPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _mRecorder!.closeRecorder();
    _mRecorder = null;
    titleController.dispose();

    _mPlayer!.closePlayer();
    _mPlayer = null;

    super.dispose();
  }

  Future<void> openTheRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await _mRecorder!.openRecorder();
  }
  // ----------------------  Here is the code for recording and playback -------

  void record() {
    _mRecorder!.startRecorder(
      toFile: mPath,
      codec: codec,
    );
    isRecord.value = true;
  }

  void stopRecorder() {
    _mRecorder!.stopRecorder();
    isRecord.value = false;
  }

  void closeRecorder() {
    _mRecorder!.closeRecorder();
    Controller.to.add(HomeItem(
        child: AudioNote(
          path: mPath,
        ),
        location: ItemLocation(
            inDirectory: Controller.to.selectedFolder.value,
            index: Controller.to.all[Controller.to.selectedFolder.value]
                    .childrens.length -
                1)));
    Get.back();
  }

  void play() {
    stopRecorder();
    _mPlayer!.startPlayer(fromURI: mPath, codec: codec);
  }

  void stopPlayer() {
    _mPlayer!.stopPlayer();
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
              hintText: 'Title',
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(width: 1, color: Colors.red)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    width: 1,
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    width: 1,
                  )),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    width: 1,
                  )),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  width: 1,
                ),
              )),
        ),
        leading: IconButton(
            splashRadius: 20,
            onPressed: () {
              Get.back();
              closeRecorder();
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              splashRadius: 20,
              onPressed: () {
                closeRecorder();
              },
              icon: const Icon(Icons.add))
        ],
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
                      onTap: record,
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
