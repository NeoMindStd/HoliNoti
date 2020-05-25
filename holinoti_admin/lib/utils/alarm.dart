import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notification {
  Future launcher() async {
    WidgetsFlutterBinding.ensureInitialized();
    var initAndroidSetting =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initIosSetting = IOSInitializationSettings();
    var initSetting =
        InitializationSettings(initAndroidSetting, initIosSetting);
    await FlutterLocalNotificationsPlugin().initialize(initSetting);
  }

  Future showNotification() async {
    var android = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription');
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);

    await FlutterLocalNotificationsPlugin().show(0, 'title', 'body', platform);
  }

  Future showNotificationSchedule() async {
    var android = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription');
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);

    await FlutterLocalNotificationsPlugin().schedule(
        0, 'title', 'body', DateTime.parse('2020-05-20 16:53:00'), platform);
  }
}
