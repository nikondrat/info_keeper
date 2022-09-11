import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/chat/chat.dart';
import 'package:info_keeper/model/types/home/chat/items/file.dart';
import 'package:info_keeper/model/types/home/chat/items/image.dart';
import 'package:info_keeper/model/types/home/chat/items/voice.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/model/types/item_location.dart';

enum MusicFormat { ogg, mp3, flac, wav, acc }

enum ImageFormat { jpeg, png, gif, bmp, webp, wbmp, jpg }

class ChatBottomFileSelectorButton extends StatelessWidget {
  final HomeItem homeItem;
  const ChatBottomFileSelectorButton({Key? key, required this.homeItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Chat chat = homeItem.child;
    RxList messages = chat.messages;

    pickFiles() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        PlatformFile selectedFile = result.files.single;
        final String name = selectedFile.path!.split('/').last.split('.').first;
        final String type = selectedFile.path!.split('/').last.split('.').last;

        final imageFormat = ImageFormat.values.firstWhereOrNull(
            (element) => element.toString() == 'ImageFormat.$type');
        final musicFormat = MusicFormat.values.firstWhereOrNull(
            (element) => element.toString() == 'MusicFormat.$type');

        if (imageFormat != null) {
          messages.insert(
              0,
              ChatImage(
                  path: selectedFile.path!,
                  location: ItemLocation(
                      inDirectory: homeItem.location.inDirectory,
                      index: homeItem.location.index,
                      itemIndex: messages.length),
                  dateTime: DateTime.now()));
          chat.copyWith(messages: messages);
        } else if (musicFormat != null) {
          Codec codec = Codec.aacADTS;

          switch (musicFormat) {
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
        } else {
          messages.insert(
              0,
              ChatFile(
                  name: name,
                  path: selectedFile.path!,
                  location: ItemLocation(
                      inDirectory: homeItem.location.inDirectory,
                      index: homeItem.location.index,
                      itemIndex: messages.length),
                  dateTime: DateTime.now()));
          chat.copyWith(messages: messages);
        }
      }
    }

    return IconButton(
      splashRadius: 20,
      onPressed: pickFiles,
      icon: const Icon(Icons.attach_file),
    );
  }
}
