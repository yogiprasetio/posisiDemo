import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:workmanager/workmanager.dart';

import 'core/core.dart';
import 'ui/pages/pages.dart';
import 'ui/widgets/widgets.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setPermission().requestPermission();
  await NotificationWidget.init();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  FlutterNativeSplash.remove();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

void listenNotifications() =>
    NotificationWidget.onNotifications.stream.listen(onClickedNotification);

//Event On Clicked Notifiication-
void onClickedNotification(NotificationResponse? payload) => main();
