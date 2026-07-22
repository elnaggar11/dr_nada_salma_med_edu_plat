import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/profiles/presentation/cubit/profile/profile_cubit.dart';

import 'package:device_preview/device_preview.dart';
import 'app_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'features/notifications/notifications_handler.dart';
import 'firebase_options.dart';
import 'injection_container/injection_container.dart' as di;
import 'package:screen_protector/screen_protector.dart';

// 50 34 36

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
    alert: true,

    badge: true,
    sound: true,
  );

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => EasyLocalization(
        supportedLocales: const [Locale('ar'), Locale('en')],
        path: "assets/translate",
        // startLocale: Locale("ar"),
        startLocale: Locale("ar"),
        saveLocale: true,
        useOnlyLangCode: true,
        child: MyApp(appRoutes: AppRoutes()),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.appRoutes});
  final AppRoutes appRoutes;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    ScreenProtector.preventScreenshotOn();
  }

  @override
  void dispose() {
    ScreenProtector.preventScreenshotOff();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(create: (context) => di.sl<ProfileCubit>()),
      ],
      child: MaterialApp(
        onGenerateRoute: widget.appRoutes.onGenerateRoutes,
        debugShowCheckedModeBanner: false,
        scrollBehavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        ),
        navigatorKey: navKey,
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        scaffoldMessengerKey: msgKey,
      ),
    );
  }
}
