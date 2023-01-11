import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:info_keeper/app/models/folder.dart';
import 'package:info_keeper/app/values/values.dart';

class FolderItemWidget extends StatelessWidget {
  final Folder folder;
  const FolderItemWidget({super.key, required this.folder});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(kDefaultRadius)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(folder.title,
                style: Theme.of(context).textTheme.subtitle1,
                overflow: TextOverflow.ellipsis),
            AutoSizeText('${folder.children.length}')
          ],
        ));
  }
}
