import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notification/screen/secod_page.dart';

import 'screen/home_page.dart';

int id = 0;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

/// Streams to handle notification-related events
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
StreamController<ReceivedNotification>.broadcast();
final StreamController<String?> selectNotificationStream =
StreamController<String?>.broadcast();

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

/// A notification action that triggers an App navigation event
const String navigationActionId = 'id_3';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with payload: ${notificationResponse.payload}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeNotifications();

  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  String initialRoute = HomePage.routeName;

  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload =
        notificationAppLaunchDetails!.notificationResponse?.payload;
    initialRoute = SecondPage.routeName;
  }

  runApp(
    MaterialApp(
      initialRoute: initialRoute,
      routes: <String, WidgetBuilder>{
        HomePage.routeName: (_) => HomePage(notificationAppLaunchDetails),
        SecondPage.routeName: (_) => SecondPage(selectedNotificationPayload)
      },
    ),
  );
}


Future<void> _initializeNotifications() async {

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  final DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {
      didReceiveLocalNotificationStream.add(
        ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        ),
      );
    },
  );

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      if (notificationResponse.notificationResponseType ==
          NotificationResponseType.selectedNotification ||
          notificationResponse.actionId == navigationActionId) {
        selectNotificationStream.add(notificationResponse.payload);
      }
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

}
