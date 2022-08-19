import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:info_keeper/model/types/home_item.dart';

class AudioNoteItem extends StatelessWidget {
  final HomeItem homeItem;
  const AudioNoteItem({Key? key, required this.homeItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(homeItem.name),
    );
  }
}
