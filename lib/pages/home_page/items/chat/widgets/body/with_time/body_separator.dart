import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ChatBodySeparator extends StatelessWidget {
  final DateTime dateTime;
  const ChatBodySeparator({Key? key, required this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var months = [
      'December',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
    ];

    String year =
        dateTime.year != DateTime.now().year ? dateTime.year.toString() : '';

    return LayoutBuilder(
        builder: (context, constraints) =>
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              LimitedBox(
                  maxWidth: year.isNotEmpty
                      ? constraints.maxWidth * 0.4
                      : constraints.maxWidth * 0.34,
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(6)),
                      child: AutoSizeText(
                          '${dateTime.day} ${months[dateTime.month]} $year',
                          style: Theme.of(context).textTheme.bodyText1)))
            ]));
  }
}
