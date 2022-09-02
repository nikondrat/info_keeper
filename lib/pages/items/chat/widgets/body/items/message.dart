import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home/chat/items/message.dart';
import 'package:info_keeper/pages/items/chat/widgets/body/items/item_decoration.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final double elevation;
  const MessageWidget({Key? key, required this.message, this.elevation = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemDecoration(
        color: message.color,
        elevation: elevation,
        padding: EdgeInsets.zero,
        dateTime: message.dateTime,
        child: GestureDetector(
          onTap: () => showMaterialModalBottomSheet(
              context: context,
              builder: (context) => ListView(
                    children: [
                      Text('hello'),
                      Text('hello'),
                      Text('hello'),
                    ],
                  )),
          child: message.title.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.grey.shade400),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(message.title),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(message.content),
                      )
                    ])
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(message.content),
                ),
        ));
  }
}
