import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/location_element.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;

class Notifications extends StatefulWidget {
  final String name;
  final String? messageText;
  final bool isStorageFile;
  final LocationElement locElement;
  const Notifications(
      {Key? key,
      required this.locElement,
      this.isStorageFile = false,
      required this.name,
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
    //     widget.locElement.index,
    //     widget.messageText == null ? 'Notification' : widget.name,
    //     widget.messageText ?? widget.name,
    //     platformChannelSpecifics,
    //     payload: jsonEncode(widget.locElement));

    await flutterLocalNotificationsPlugin.zonedSchedule(
      widget.locElement.index,
      widget.messageText == null ? 'Notification' : widget.name,
      widget.messageText ?? widget.name,
      tz.TZDateTime.from(selected, selected.location),
      platformChannelSpecifics,
      payload: jsonEncode(widget.locElement),
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

    return widget.locElement.selectedMessageIndex != null
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
              DateTime? picker = await showOmniDateTimePicker(
                  context: context, is24HourMode: true);
              if (picker != null) {
                selectedDateTime = picker;
                showNotification(selectedDateTime);
              }

              Controller.to.isShowMenu.value = false;
            },
            icon: const Icon(Icons.notifications_none));
  }
}
