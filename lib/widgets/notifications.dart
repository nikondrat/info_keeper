import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/home_controller.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;

class Notifications extends StatefulWidget {
  final String? messageText;
  final bool isStorageFile;
  final HomeItem homeItem;
  const Notifications(
      {Key? key,
      required this.homeItem,
      this.isStorageFile = false,
      this.messageText})
      : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      const AndroidNotificationDetails('com.example.info_keeper', 'info keeper',
          icon: 'ic_stat_name',
          importance: Importance.max,
          priority: Priority.high);

  late NotificationDetails platformChannelSpecifics;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    super.initState();
  }

  Future<void> showNotification(DateTime selectedDate) async {
    final tz.TZDateTime selected = tz.TZDateTime(
        tz.local,
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedDate.hour,
        selectedDate.minute);

    // await flutterLocalNotificationsPlugin.show(
    //     widget.homeItem.location.index,
    //     widget.messageText == null ? 'Notification' : widget.homeItem.name,
    //     widget.messageText ?? widget.homeItem.name,
    //     platformChannelSpecifics,
    //     payload: jsonEncode(widget.homeItem));

    await flutterLocalNotificationsPlugin.zonedSchedule(
      widget.homeItem.location.index,
      widget.messageText == null ? 'Notification' : widget.homeItem.name,
      widget.messageText ?? widget.homeItem.name,
      tz.TZDateTime.from(selected, selected.location),
      platformChannelSpecifics,
      payload: jsonEncode(widget.homeItem),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime = DateTime.now();

    if (widget.isStorageFile) {
      return GestureDetector(
        onTap: () async {
          Navigator.pop(context);
          DateTime? picker = await showOmniDateTimePicker(
              context: context, is24HourMode: true);

          if (picker != null) {
            selectedDateTime = picker;
            showNotification(selectedDateTime);
          }
        },
        child: Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(Icons.notifications_none),
            ),
            Text('Remind')
          ],
        ),
      );
    }

    return widget.homeItem.location.itemIndex != null
        ? TextButton.icon(
            style: const ButtonStyle(
              alignment: Alignment.centerLeft,
            ),
            onPressed: () async {
              Navigator.pop(context);
              DateTime? picker = await showOmniDateTimePicker(
                  context: context, is24HourMode: true);

              if (picker != null) {
                selectedDateTime = picker;
                showNotification(selectedDateTime);
              }
            },
            icon: const Icon(Icons.notifications_none),
            label: const Text(
              'Remind',
            ))
        : IconButton(
            splashRadius: 20,
            onPressed: () async {
              late final HomeController home = Get.find();
              DateTime? picker = await showOmniDateTimePicker(
                  context: context, is24HourMode: true);
              if (picker != null) {
                selectedDateTime = picker;
                showNotification(selectedDateTime);
              }

              home.isShowBottomMenu.value = false;
            },
            icon: const Icon(Icons.notifications_none));
  }
}
