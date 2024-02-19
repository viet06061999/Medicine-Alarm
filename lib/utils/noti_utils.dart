import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medicine_alarm/constants.dart';
import 'package:medicine_alarm/models/medicine.dart';

import 'time_utils.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
            'repeatDailyAtTime channel id', 'repeatDailyAtTime channel name',
            importance: Importance.max,
            ledColor: kOtherColor,
            priority: Priority.high,
            category: AndroidNotificationCategory.reminder,
            ledOffMs: 1000,
            // fullScreenIntent: true,
            ledOnMs: 1000,
            enableLights: true),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future<void> scheduleNotification(Medicine medicine) async {
    for (var day in medicine.days) {
      var txTime = TimeUtils.createTZDateTimeForDayOfWeek(
          int.parse(day), medicine.startTime);
      print('schedule weekly at $txTime');
      await notificationsPlugin.zonedSchedule(
          int.parse(day),
          'Reminder weekly: ${medicine.medicineName}',
          'It is time to take your medicine, according to schedule',
          txTime,
          notificationDetails(),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
    }
  }

  Future<void> scheduleNextNotification(Medicine medicine) async {
    for (var day in medicine.days) {
      var txTime = TimeUtils.createTZDateTimeNext(medicine.getInterval);

      print('schedule at ${txTime}');
      await notificationsPlugin.zonedSchedule(
          int.parse(day),
          'Reminder: ${medicine.medicineName}',
          'It is time to take your medicine, according to schedule',
          txTime,
          notificationDetails(),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
    }
  }
}
