import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home/chat/items/file.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/items/item_decoration.dart';
import 'package:open_filex/open_filex.dart';

class ChatFileWidget extends StatelessWidget {
  final ChatFile file;
  final double elevation;
  const ChatFileWidget({super.key, this.elevation = 0, required this.file});

  @override
  Widget build(BuildContext context) {
    return ItemDecoration(
        index: file.location.itemIndex!,
        dateTime: file.dateTime,
        elevation: elevation,
        child: GestureDetector(
          onTap: () async => await OpenFilex.open(file.path),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.file_copy),
              ),
              Expanded(child: Text(file.name))
            ],
          ),
        ));
  }
}
