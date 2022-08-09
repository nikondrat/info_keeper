import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/controller.dart';
import 'package:info_keeper/model/types/all.dart';
import 'package:info_keeper/model/types/location_element.dart';
import 'package:info_keeper/pages/chat_page/chat_page.dart';
import 'package:info_keeper/pages/home_page/home_page.dart';
import 'package:info_keeper/pages/storage_file_page/storage_file_page.dart';
import 'package:info_keeper/pages/todo_page/todo_page.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest_all.dart' as tz;
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;

notificationInit() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_stat_name');
  const IOSInitializationSettings initializationSettingsIos =
      IOSInitializationSettings();

  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  configureLocalTimeZone();

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  const MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );
  final LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(
    defaultActionName: 'Open notification',
    defaultIcon: AssetsLinuxIcon('ntf_icon.png'),
  );
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      macOS: initializationSettingsMacOS,
      linux: initializationSettingsLinux,
      iOS: initializationSettingsIos);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      final Map<String, dynamic> element = jsonDecode(payload);
      final LocationElement elementData = LocationElement.fromJson(element);

      var item = Controller.to.all[elementData.inDirectory]
          .directoryChildrens[elementData.index];

      switch (item.type) {
        case AllType.chat:
          return Get.to(() => ChatPage(
              chatIndex: elementData.index,
              messageIndex: elementData.selectedMessageIndex));
        case AllType.storageFile:
          return Get.to(() => StorageFilePage(file: item, change: true));
        case AllType.todo:
          return Get.to(() => TodoPage(todo: item, change: true));
        case AllType.audioNote:
          Controller.to.selectedFolder.value = elementData.inDirectory;
          return Get.to(() => const HomePage());
      }
    }
  });
}
