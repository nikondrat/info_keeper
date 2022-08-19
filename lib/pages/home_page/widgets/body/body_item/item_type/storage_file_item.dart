import 'package:flutter/material.dart';
import 'package:info_keeper/model/types/home_item.dart';

class StorageFileItem extends StatelessWidget {
  final HomeItem homeItem;
  const StorageFileItem({Key? key, required this.homeItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(homeItem.name),
    );
  }
}
