part of 'widgets.dart';

class NotificationWidget {
  NotificationWidget();
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<NotificationResponse?>();
  final id = 0;

  Future<void> setup() async {
    // #1
    const androidSetting = AndroidInitializationSettings('real_sbs');
    const iosSetting = DarwinInitializationSettings();

    // #2
    const initSettings =
        InitializationSettings(android: androidSetting, iOS: iosSetting);

    // #3
    await _notifications.initialize(initSettings).then((_) {
      debugPrint('_');
    }).catchError((Object error) {
      debugPrint('Plugin Error: $error');
    });
  }

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'OBA',
        'Demo Background Task',
        importance: Importance.max,
        ticker: "OBA",
        styleInformation: DefaultStyleInformation(true, true),
        playSound: true,
      ),
      // iOS: DarwinNotificationDetails()
      iOS: DarwinNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    const androidSettings = AndroidInitializationSettings('real_sbs');
    var iosSetting = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});
    var settings =
        InitializationSettings(android: androidSettings, iOS: iosSetting);

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) async {
        onNotifications.add(payload);
      },
    );
  }

  static Future tampilNotifikasi({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(id, title, body, await _notificationDetails(),
          payload: payload);
}
