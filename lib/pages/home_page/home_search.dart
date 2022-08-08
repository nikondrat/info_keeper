import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/pages/home_page/home_widget/home_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchQueryController = TextEditingController();
    RxList<SearchElement> searchResult = <SearchElement>[].obs;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              splashRadius: 20,
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back)),
          actions: [
            IconButton(
              onPressed: () {
                searchQueryController.clear();
                searchResult.clear();
              },
              icon: const Icon(Icons.close),
              splashRadius: 20,
            )
          ],
          title: TextField(
            autocorrect: true,
            controller: searchQueryController,
            cursorColor: Colors.black,
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: 'Text'),
            onChanged: (text) {
              searchResult.clear();
              for (var allList in Controller.to.all) {
                for (var element in allList.directoryChildrens) {
                  if (searchQueryController.text.isNotEmpty) {
                    if (element.name.toLowerCase().contains(text)) {
                      searchResult.add(SearchElement(
                          index: allList.directoryChildrens.indexOf(element),
                          directoryIndex: Controller.to.all.indexOf(allList),
                          element: element));
                    }
                  }
                }
              }
            },
          ),
        ),
        body: Obx(() => MasonryGridView.builder(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            gridDelegate: const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200),
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            itemCount: searchResult.length,
            itemBuilder: (context, searchResultIndex) {
              return HomeWidget(
                value: searchResult[searchResultIndex].element,
                index: searchResult[searchResultIndex].index,
                term: searchQueryController.text,
              );
            })));
  }
}

class SearchElement {
  int index;
  int directoryIndex;
  dynamic element;
  SearchElement(
      {required this.index,
      required this.directoryIndex,
      required this.element});
}
