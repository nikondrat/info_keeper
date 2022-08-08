import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/pages/home_page/home_widget/home_widget.dart';

class HomePageBody extends StatelessWidget {
  final RxBool isGridView;
  const HomePageBody({Key? key, required this.isGridView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Obx(
        () => Controller.to.all.isNotEmpty
            ? MasonryGridView.count(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                crossAxisCount: isGridView.value ? 2 : 1,
                itemCount: Controller.to.all[Controller.to.selectedFolder.value]
                    .directoryChildrens.length,
                itemBuilder: (context, index) {
                  return Controller.to.all[Controller.to.selectedFolder.value]
                          .directoryChildrens[index].isLocked
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.all(5),
                          child: HomeWidget(
                            value: Controller
                                .to
                                .all[Controller.to.selectedFolder.value]
                                .directoryChildrens[index],
                            index: index,
                          ),
                        );
                })
            : const Center(
                child: Text('Empty'),
              ),
      ),
    );
  }
}
