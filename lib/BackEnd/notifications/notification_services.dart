import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widget/AppText.dart';
import '../../firebase_options.dart';


class LocalNotificationServices {
  static final FlutterLocalNotificationsPlugin _notification =
      FlutterLocalNotificationsPlugin();

  ///initialize local notification ------------------------------------------------------------------------------------
  static Future<void> initialize() async {
    NotificationAppLaunchDetails? notificationAppLaunchDetails;
    const AndroidInitializationSettings initAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initIos = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initAndroid, iOS: initIos);

    await _notification.initialize(initializationSettings,
        onDidReceiveNotificationResponse:

            ///handel on tap notification in background and foreground state
            onTapNotificationForegroundBackground);

    ///handel on tap notification in terminate state
    onTapNotificationTerminate(notificationAppLaunchDetails);
  }

  ///request permission ------------------------------------------------------------------------------------
  static Future<bool> requestPermissions() async {
    bool result = false;
    if (Platform.isIOS) {
      await _notification
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _notification.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
          await androidImplementation?.requestNotificationsPermission();

      result = grantedNotificationPermission ?? false;
    }
    return result;
  }

  ///check if notification permission enable or not ------------------------------------------------------------------------------------
  static Future<bool> isAndroidPermissionGranted() async {
    bool granted = false;
    if (Platform.isAndroid) {
      granted = await _notification
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
    }
    return granted;
  }

  /// display notification ------------------------------------------------------------------------------------
  static showNotification(RemoteMessage message) async {
    try {
      var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'channel_id',
        'channel name',
        icon: '@mipmap/ic_launcher',
        channelDescription: 'channel description',
        importance: Importance.max,
        priority: Priority.high,
      );
      var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
          // presentSound: true, presentBadge: true, presentAlert: true
          );
      var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      Platform.isIOS
          ? await FirebaseMessaging.instance
              .setForegroundNotificationPresentationOptions(
              alert: true,
              badge: true,
              sound: true,
            )
          : null;
      color_print('data message in show: ${message.data}');
      if (message.data['body'] != null || message.data['title'] != null) {
        color_print('\x1B[33m payload in show: ${json.encode(message.data)}\x1B[0m');
        int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

        await _notification.show(id, message.data['title'],
            message.data['body'], platformChannelSpecifics,
            payload: json.encode(message.data));
      }
    } catch (e) {
      color_print('\x1B[33m Error in show notification: ${e.toString()}\x1B[0m');
    }
  }

  ///remove one notification from status bar------------------------------------------------------------------------------------
  static void closeOneNotification({required int notificationId}) async {
    await _notification.cancel(notificationId);
    color_print('notification removed successful');
  }

  ///remove all notification from status bar------------------------------------------------------------------------------------
  static void closeAllNotifications() async {
    await _notification.cancelAll();
    color_print('all notifications removed');
  }

  ///handle on tab foreground-background message ------------------------------------------------------------------------------------
  static void onTapNotificationForegroundBackground(
      NotificationResponse response) {
    color_print('\x1B[33m _handleMessage: ${response.payload}\x1B[0m');
    if (response.payload != null) {
      Map<String, dynamic> payload = json.decode(response.payload!);
      if (payload['type'] == "notification") {
        // MyApp.myNavigatorKey.currentState?.pushNamedAndRemoveUntil(
        //     NotificationsHome.routeName, (route) => route.isFirst);
      }
    }
  }

  ///handel on tap notification in terminate state ------------------------------------------------------------------------------------
  static void onTapNotificationTerminate(
      NotificationAppLaunchDetails? notificationAppLaunchDetails) async {
    notificationAppLaunchDetails =
        await _notification.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails != null &&
        notificationAppLaunchDetails.didNotificationLaunchApp) {
      onTapNotificationForegroundBackground(
          notificationAppLaunchDetails.notificationResponse!);
      notificationAppLaunchDetails = null;
    }
  }

  ///handel on background message ------------------------------------------------------------------------------------
  ///@pragma('vm:entry-point') use for indicate to the compiler that it will be used from native code(run dart code only).
  ///isolate method
  @pragma('vm:entry-point')
  static Future<void> onBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await LocalNotificationServices.showNotification(message);
    await removeCount();

    ///store notification count to share prefers
    await setCount(count: json.decode(message.data['count_of_notifications']));
    color_print('Handling a background message body ${message.data['body']}');
    getCount();
  }

  ///get notifications count when app in background===========================================================================
  static Future<Map<String, dynamic>?> getCount() async {
    Map<String, dynamic>? count;
    color_print('read notifications count from SharedPreferences');
    final prefs = await SharedPreferences.getInstance();

    ///that the background handler run in a different isolate so,
    /// when you try to get a data, the shared preferences instance is empty.
    /// To avoid this you simply have to force a refresh:
    await prefs.reload();
    const key = 'notifications';
    String? value = prefs.getString(key);
    if (value != null) {
      count = json.decode(prefs.getString(key)!);
    }
    color_print('\x1B[33m SharedPreferences notifications info: $value\x1B[0m');
    return count;
  }

  ///save notifications count when app in background===========================================================================
  static Future<void> setCount({int? count, bool? isForegroundMessage}) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'notifications';
    final value = {
      'type': isForegroundMessage == true ? 'foreground' : 'background',
      'count': count,
    };
    bool isAdd = await prefs.setString(key, json.encode(value));
    color_print('notifications setCount: $isAdd');
  }

  ///remove Count ==========================================================================
  static Future<void> removeCount() async {
    final prefs = await SharedPreferences.getInstance();
    bool de = await prefs.remove('notifications');
    color_print('remove notification Count from SharedPreferences $de');
  }
}



