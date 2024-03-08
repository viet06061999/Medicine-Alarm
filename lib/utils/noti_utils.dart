import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medicine_alarm/constants.dart';
import 'package:medicine_alarm/generated/l10n.dart';
import 'package:medicine_alarm/global_bloc.dart';
import 'package:medicine_alarm/models/medicine.dart';
import 'package:sizer/sizer.dart';

import 'time_utils.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@pragma("vm:entry-point")
onDidReceiveBg(NotificationResponse notificationResponse) {
  print('action tap ${notificationResponse.payload}');
  var data = notificationResponse.payload;
  if (data == null) return;
  Map<String, dynamic> jsonData = jsonDecode(data);
  var id = jsonData['medicineId'];
  if (id == null || notificationResponse.actionId == null) return;
  if (notificationResponse.actionId == NotificationService.remindLater) {
    print('id ${notificationResponse.actionId}');
    tz.initializeTimeZones();
    FlutterTimezone.getLocalTimezone().then((currentTimeZone) {
      tz.setLocalLocation(tz.getLocation(currentTimeZone));
      NotificationService().scheduleRemindNotification(
        jsonData['title'] as String,
        jsonData['body'] as String,
        jsonData['remindLater'] as String,
        data,
      );
      Fluttertoast.showToast(
          msg: jsonData['remind'] as String,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black.withOpacity(0.8),
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}

class NotificationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final NotificationService _instance = NotificationService._internal();

  static const int dayNotification = 2;
  static const int otherNotification = 3;
  static const int remindNotification = 5;
  static const String remindLater = '4';

  // Khai báo một hàm factory để trả về thể hiện duy nhất của NotificationService
  factory NotificationService() {
    return _instance;
  }

  // Hàm khởi tạo private để chỉ có thể được gọi từ bên trong lớp
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('ic_medication');

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
        onDidReceiveNotificationResponse: onDidReceive,
        onDidReceiveBackgroundNotificationResponse: onDidReceiveBg);
  }

  onDidReceive(NotificationResponse notificationResponse) async {
    var data = notificationResponse.payload;
    if (data == null) return;
    Map<String, dynamic> jsonData = jsonDecode(data);
    if (jsonData["medicineId"] != null) {
      int id = jsonData["medicineId"] as int;
      if (NotificationService.navigatorKey.currentContext != null) {
        Navigator.pushNamedAndRemoveUntil(
            NotificationService.navigatorKey.currentContext!,
            "/",
            (route) => false,
            arguments: id);
      }
    }
  }

  notificationDetails({String? later}) {
    return NotificationDetails(
        android: AndroidNotificationDetails(
            'repeatDailyAtTime channel id', 'repeatDailyAtTime channel name',
            importance: Importance.max,
            ledColor: kOtherColor,
            priority: Priority.high,
            category: AndroidNotificationCategory.reminder,
            ledOffMs: 1000,
            playSound: true,
            ledOnMs: 1000,
            enableLights: true,
            audioAttributesUsage: AudioAttributesUsage.alarm,
            actions: [
              AndroidNotificationAction(
                  remindLater, later ?? S.current.remind_later)
            ]),
        iOS: DarwinNotificationDetails());
  }

  Future<void> scheduleNotification(Medicine medicine, GlobalBloc? bloc,
      {int after = 0}) async {
    await cancelAll(medicine);
    List<int> notificationIds = [];
    var isAll = medicine.days.length == 1 && medicine.days[0] == "0";
    var nextTime = medicine.next;
    print('next at $nextTime');
    var days = medicine.days;
    if (isAll) {
      days = ["1", "2", "3", "4", "5", "6", "7"];
    }
    var lastTime = medicine.last;
    for (var day in days) {
      for (TimeOfDay time in medicine.times ?? []) {
        final jsonData = {
          'medicineId': medicine.id,
          'title':
              S.current.title_noti(TimeUtils.formatTimeOfDay(time: time) ?? ""),
          'body': S.current.content_noti,
          'remindLater': S.current.remind_later,
          'remind': S.current.remind
        };
        var dateTime = TimeUtils.getDateTime(time);
        tz.TZDateTime txTime;
        var isContinue = ((lastTime != null &&
                    nextTime != null &&
                    dateTime.isAfter(lastTime) &&
                    dateTime.isBefore(nextTime)) ||
                (lastTime != null &&
                    nextTime == null &&
                    dateTime.isAfter(lastTime))) &&
            dateTime.weekday.toString() == day;
        if (isContinue) {
          for (var i = 1; i < 9; i++) {
            txTime =
                TimeUtils.createTZDateTimeForDayOfWeek(int.parse(day), time)
                    .add(Duration(days: i * 7));
            var id = int.parse(
                '${medicine.id}$otherNotification${txTime.day}${time.hour}');
            notificationIds.add(id);
            print('zonedSchedule at $txTime $id');
            await notificationsPlugin.zonedSchedule(
              id,
              S.current.title_noti(TimeUtils.formatTimeOfDay(time: time) ?? ""),
              S.current.content_noti,
              txTime,
              notificationDetails(),
              androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
              uiLocalNotificationDateInterpretation:
                  UILocalNotificationDateInterpretation.absoluteTime,
              matchDateTimeComponents: DateTimeComponents.dateAndTime,
              payload: jsonEncode(jsonData),
            );
          }
        } else {
          txTime = TimeUtils.createTZDateTimeForDayOfWeek(int.parse(day), time);
          var id = int.parse('${medicine.id}$dayNotification$day${time.hour}');
          notificationIds.add(id);
          print('zonedSchedule at $txTime $id');
          await notificationsPlugin.zonedSchedule(
            id,
            S.current.title_noti(TimeUtils.formatTimeOfDay(time: time) ?? ""),
            S.current.content_noti,
            txTime,
            notificationDetails(),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
            matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
            payload: jsonEncode(jsonData),
          );
        }
      }
    }
    medicine.notificationIDs = notificationIds;
    bloc?.updateMedicine(medicine);
  }

  cancelAll(Medicine medicine) async {
    for (var id in medicine.notificationIDs ?? []) {
      await notificationsPlugin.cancel(id);
    }
    await notificationsPlugin.cancel(remindNotification);
  }

  Future<void> scheduleRemindNotification(
      String title, String content, String later, String payload) async {
    var txTime = TimeUtils.nextMinutes(3);
    await notificationsPlugin.zonedSchedule(remindNotification, title, content,
        txTime, notificationDetails(later: later),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
        payload: payload);
  }

  Future openAlertBox(String title,
      {String? content,
      String? negative,
      String? positive,
      Function? onNegative,
      Function? onPositive}) async {
    if (NotificationService.navigatorKey.currentContext == null) {
      return;
    }
    return await showDialog(
      barrierDismissible: false,
      context: NotificationService.navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          backgroundColor: kScaffoldColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          contentPadding: EdgeInsets.only(top: 1.h, left: 1.h, right: 1.h),
          actionsPadding: EdgeInsets.only(top: 1.h),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: content != null
              ? Text(
                  content,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: kOrange),
                )
              : null,
          actions: [
            TextButton(
              onPressed: () {
                onNegative?.call();
                Navigator.pop(context);
              },
              child: Text(
                negative ?? S.current.cancel,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            TextButton(
              onPressed: () {
                //global block to delete medicine,later
                onPositive?.call();
                Navigator.pop(context);
              },
              child: Text(
                positive ?? S.current.ok,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        );
      },
    );
  }
}
