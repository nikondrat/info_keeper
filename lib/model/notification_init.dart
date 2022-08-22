import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
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
      // final Map<String, dynamic> element = jsonDecode(payload);
      // final ItemLocation elementData = ItemLocation.fromJson(element);

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
