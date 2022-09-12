import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:info_keeper/model/types/home/home.dart';
import 'package:info_keeper/model/types/home_item.dart';
import 'package:info_keeper/pages/home_page/items/chat/chat_page.dart';
import 'package:info_keeper/pages/home_page/items/storage_file/storage_file_page.dart';
import 'package:info_keeper/pages/home_page/items/task/task_page.dart';
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
      final Map<String, dynamic> jsonMapItem = jsonDecode(payload);
      final HomeItem item = HomeItem.fromJson(jsonMapItem);

      switch (item.child.type) {
        case HomeType.chat:
          Get.to(() => ChatPage(homeItem: item));
          break;
        case HomeType.storageFile:
          Get.to(() => StorageFilePage(homeItem: item));
          break;
        case HomeType.task:
          Get.to(() => TaskPage(homeItem: item));
          break;
        default:
      }

      // var item = Controller
      //     .to.all[elementData.inDirectory].childrens[elementData.index];

      // switch (item.type) {
      //   case AllType.chat:
      //     return Get.to(() => ChatPage(
      //         chatIndex: elementData.index,
      //         messageIndex: elementData.selectedMessageIndex));
      //   case AllType.storageFile:
      //     return Get.to(() => StorageFilePage(homeItem: item, change: true));
      //   case AllType.todo:
      //     return Get.to(() => TodoPage(todo: item, change: true));
      //   case AllType.audioNote:
      //     Controller.to.selectedFolder.value = elementData.inDirectory;
      //     return Get.to(() => const HomePage());
      // }
    }
  });
}
