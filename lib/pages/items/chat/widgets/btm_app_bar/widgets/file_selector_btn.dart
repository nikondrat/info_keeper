import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/items/voice.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/item_location.dart';

enum MusicFormat { webm, ogg, mp3, flac, wav, acc }

enum ImageFormat { jpeg, png, gif, bmp, webp, wbmp, jpg }

class ChatBottomFileSelectorButton extends StatelessWidget {
  final HomeItem homeItem;
  const ChatBottomFileSelectorButton({Key? key, required this.homeItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Chat chat = homeItem.child;
    RxList messages = chat.messages;

    void pickFiles() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        PlatformFile selectedFile = result.files.single;
        final String name = selectedFile.path!.split('/').last.split('.').first;
        final String type = selectedFile.path!.split('/').last.split('.').last;

        final imageFormat = ImageFormat.values.firstWhereOrNull(
            (element) => element.toString() == 'ImageFormat.$type');
        final musicFormat = MusicFormat.values.firstWhereOrNull(
            (element) => element.toString() == 'MusicFormat.$type');

        if (musicFormat != null) {
          Codec codec = Codec.aacADTS;

          switch (musicFormat) {
            case MusicFormat.webm:
              codec = Codec.opusWebM;
              break;
            case MusicFormat.flac:
              codec = Codec.flac;
              break;
            case MusicFormat.mp3:
              codec = Codec.mp3;
              break;
            case MusicFormat.ogg:
              codec = Codec.opusOGG;
              break;
            case MusicFormat.wav:
              codec = Codec.pcm16WAV;
              break;
            default:
          }

          messages.insert(
              0,
              ChatVoice(
                  name: name,
                  codec: codec,
                  path: selectedFile.path!,
                  location: ItemLocation(
                      inDirectory: homeItem.location.inDirectory,
                      index: homeItem.location.index,
                      itemIndex: messages.length),
                  dateTime: DateTime.now()));
          chat.copyWith(messages: messages);
          Controller.to.setData();
        }

        // final File file = File('${result.files.single.path}');
        // final String path = '${dir.path}/${result.files.single.name}';
        // await file.copy(path);

        // if (imageFormat != null) {
        //   Controller.to.addChatImage(OldChatImage(
        //       path: path,
        //       dateTime: dateTime,
        //       location: ItemLocation(
        //           inDirectory: Controller.to.selectedFolder.value,
        //           index: Controller.to.selectedElementIndex.value,
        //           itemIndex: Controller
        //               .to
        //               .all[Controller.to.selectedFolder.value]
        //               .childrens[Controller.to.selectedElementIndex.value]
        //               .child
        //               .value
        //               .messages
        //               .length)));
        // } else if (musicFormat != null) {
        //   switch (musicFormat) {
        //     case MusicFormat.webm:
        //       break;
        //     case MusicFormat.flac:
        //       break;
        //     case MusicFormat.mp3:
        //       break;
        //     case MusicFormat.ogg:
        //       break;
        //     case MusicFormat.wav:
        //       break;
        //     default:
      }
      // Controller.to.addChatVoice(OldChatVoice(
      //     name: name,
      //     path: path,
      //     codec: codec,
      //     dateTime: dateTime,
      //     location: ItemLocation(
      //         inDirectory: Controller.to.selectedFolder.value,
      //         index: Controller.to.selectedElementIndex.value,
      //         itemIndex: Controller
      //             .to
      //             .all[Controller.to.selectedFolder.value]
      //             .childrens[Controller.to.selectedElementIndex.value]
      //             .child
      //             .value
      //             .messages
      //             .length)));
      // } else {
      //   Controller.to.addChatFile(OldChatFile(
      //       name: name,
      //       path: path,
      //       location: ItemLocation(
      //           inDirectory: Controller.to.selectedFolder.value,
      //           index: Controller.to.selectedElementIndex.value,
      //           itemIndex: Controller
      //               .to
      //               .all[Controller.to.selectedFolder.value]
      //               .childrens[Controller.to.selectedElementIndex.value]
      //               .child
      //               .value
      //               .messages
      //               .length),
      //       dateTime: dateTime));
      // }
      // }
    }

    return IconButton(
        splashRadius: 20,
        onPressed: pickFiles,
        icon: const Icon(Icons.attach_file));
  }
}
