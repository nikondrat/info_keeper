import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';

class HomePageSearch extends StatelessWidget {
  const HomePageSearch({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController home = Get.find();

    RxList<HomeItem> items = <HomeItem>[].obs;

    for (var all in Controller.to.all) {
      for (var item in all.childrens) {
        if (!item.isLocked &&
            item.name.toLowerCase().contains(home.searchController.text)) {
          home.searchItems.add(item);
        }
      }
    }

    for (int i = 0; i < home.searchItems.length; i++) {
      if (!home.searchItems[i].isLocked) {
        items.add(home.searchItems[i]);
      }
    }

    search(String text) {
      home.searchItems.clear();
      if (text.isNotEmpty) {
        for (var item in items) {
          if (item.name.toLowerCase().contains(text)) {
            return home.searchItems.add(item);
          }
        }
      } else {
        home.searchItems.clear();
      }
    }

    TextField titleTextField = TextField(
        controller: home.searchController,
        cursorColor: Colors.black,
        autofocus: true,
        // focusNode: focusNode,
        // onTap: () => change.value = true,
        decoration: InputDecoration(
            hintText: 'Search',
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            counterText: '',
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.red)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            disabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6))),
        onChanged: search);

    return titleTextField;
  }
}
