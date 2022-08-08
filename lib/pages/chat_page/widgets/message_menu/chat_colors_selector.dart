import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_keeper/pages/chat_page/widgets/message_menu/chat_color_item.dart';
import 'package:info_keeper/theme.dart';

class ChatPageColorSelector extends StatelessWidget {
  final RxBool isShowColorSelector;
  final int messageColorValue;
  final RxInt selectedMessage;
  const ChatPageColorSelector(
      {Key? key,
      required this.isShowColorSelector,
      required this.messageColorValue,
      required this.selectedMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageColor = messageColorValue.obs;

    return BottomAppBar(
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          height: constraints.maxHeight * 0.16,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
          color: Colors.white,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Color select',
                        style:
                            TextStyle(color: Color(0xFF42729A), fontSize: 16),
                      ),
                    ),
                    Expanded(
                        child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: messageColors.length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 30,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 20,
                            ),
                            itemBuilder: (context, colorIndex) {
                              return ChatPageColorItem(
                                  colorIndex: colorIndex,
                                  selectedMessage: selectedMessage,
                                  selectedIndex: messageColor);
                            }))
                  ],
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  isShowColorSelector.value = false;
                },
                backgroundColor: const Color(0xFF558FBF),
                shape: const CircleBorder(side: BorderSide.none),
                highlightElevation: 0,
                elevation: 1,
                splashColor: Colors.transparent,
                mini: true,
                child: const Icon(
                  Icons.done,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
