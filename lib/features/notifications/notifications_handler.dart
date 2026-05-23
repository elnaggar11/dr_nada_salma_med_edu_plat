import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationHandler {
  /// Requests notification permissions for iOS and Android (if needed)
  static Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      sound: true,
      provisional: false,
      carPlay: false,
      criticalAlert: false,
    );

    debugPrint(
      '🔔 Notification permission status: ${settings.authorizationStatus}',
    );
  }

  /// Loads the FCM notification channel for Android
  static Future<AndroidNotificationChannel> loadFcmChannel(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  ) async {
    const channel = AndroidNotificationChannel(
      'high_importance_channel', // Channel ID
      'High Importance Notifications', // Channel Name
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      playSound: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    return channel;
  }

  /// Listens for FCM messages while the app is in foreground or background
  static void listenFCMonMessage({
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    required AndroidNotificationChannel channel,
    required GlobalKey<NavigatorState> nav,
  }) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(
        '📩 Received foreground FCM message: ${message.notification?.title}',
      );

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android.smallIcon ?? '@mipmap/ic_launcher',
              importance: Importance.high,
              priority: Priority.high,
            ),
          ),
          payload: message.data['route'] ?? '',
        );
      }
    });
  }

  /// Handles when user taps a notification that opens the app
  static void onMessageAppListen() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('🚀 Notification caused app to open: ${message.data}');

      // You can navigate based on payload here if needed:
      // final route = message.data['route'];
      // if (route != null && navKey.currentState != null) {
      //   navKey.currentState!.pushNamed(route);
      // }
    });
  }

  /// For background notifications (can be used in background handler)
  static Future<void> showFcmOnBackGround(
    RemoteMessage message,
    AndroidNotificationChannel channel,
    GlobalKey<NavigatorState> navKey,
  ) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: android.smallIcon ?? '@mipmap/ic_launcher',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
      );
    }
  }
}
