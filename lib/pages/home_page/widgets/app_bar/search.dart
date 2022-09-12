import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';

class HomePageSearch extends StatelessWidget {
  const HomePageSearch({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController home = Get.find();

    search(String text) {
      home.searchItems.clear();
      for (var all in Controller.to.all) {
        for (var item in all.childrens) {
          if (!item.isLocked && item.name.toLowerCase().contains(text)) {
            home.searchItems.add(item);
          }
        }
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
