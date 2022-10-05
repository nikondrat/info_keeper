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
        autofocus: true,
        // focusNode: focusNode,
        // onTap: () => change.value = true,
        decoration: const InputDecoration(
          hintText: 'Search',
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          counterText: '',
        ),
        onChanged: search);

    return titleTextField;
  }
}
