import 'dart:ui';

import 'package:device_preview/device_preview.dart';
import 'package:dr_nada_salma_med_edu_plat/app_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'features/notifications/notifications_handler.dart';
import 'firebase_options.dart';
import 'injection_container/injection_container.dart' as di;

GlobalKey<NavigatorState> navKey = GlobalKey();
GlobalKey<ScaffoldMessengerState> msgKey = GlobalKey();

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationHandler.loadFcmChannel(flutterLocalNotificationsPlugin).then((
    value,
  ) {
    NotificationHandler.showFcmOnBackGround(message, value, navKey);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await di.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  NotificationHandler.requestPermission();
  NotificationHandler.loadFcmChannel(flutterLocalNotificationsPlugin).then((
    value,
  ) {
    NotificationHandler.listenFCMonMessage(
      flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
      channel: value,
      nav: navKey,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    NotificationHandler.onMessageAppListen();
  });

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => EasyLocalization(
        supportedLocales: const [Locale('ar'), Locale('en')],
        path: "assets/translate",
        startLocale: Locale("ar"),
        saveLocale: true,
        useOnlyLangCode: true,
        child: MyApp(appRoutes: AppRoutes()),
      ),
      // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRoutes});
  final AppRoutes appRoutes;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: appRoutes.onGenerateRoutes,
      debugShowCheckedModeBanner: false,
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
      ),
      navigatorKey: navKey,
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      scaffoldMessengerKey: msgKey,
    );
  }
}
