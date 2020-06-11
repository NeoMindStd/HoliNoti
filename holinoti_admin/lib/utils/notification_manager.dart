import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  static final NotificationManager _instance = NotificationManager._();

  factory NotificationManager() => _instance;

  NotificationManager._();

  /// FIREBASE MESSAGING
  static bool _initialized = false;

  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future initFirebase() async {
    if (!_initialized) {
      await _firebaseMessaging.requestNotificationPermissions();
      await launcher();
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
          if (message.containsKey('notification')) {
            showNotification(
                title: message['notification']['title'],
                body: message['notification']['body']);
          }
        },
        onBackgroundMessage: onBackgroundMessage,
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
        },
      );
      getFirebaseToken();
    }
    _initialized = true;
  }

  static Future getFirebaseToken() async {
    String deviceToken = await _firebaseMessaging.getToken();
    print("FirebaseMessaging token: $deviceToken");
  }

  static Future onBackgroundMessage(Map<String, dynamic> message) async {
    print("onBackgroundMessage: $message");
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  /// LOCAL NOTIFICATION
  Future launcher() async {
    WidgetsFlutterBinding.ensureInitialized();
    var initAndroidSetting =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initIosSetting = IOSInitializationSettings();
    var initSetting =
        InitializationSettings(initAndroidSetting, initIosSetting);
    await FlutterLocalNotificationsPlugin().initialize(initSetting);
  }

  Future showNotification(
      {int id = 0, @required String title, @required String body}) async {
    var android = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription');
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);

    await FlutterLocalNotificationsPlugin().show(id, title, body, platform);
  }

  Future showNotificationSchedule(
      {int id = 0,
      @required String title,
      @required String body,
      @required DateTime dateTime}) async {
    var android = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription');
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);

    await FlutterLocalNotificationsPlugin()
        .schedule(id, title, body, dateTime, platform);
  }
}
