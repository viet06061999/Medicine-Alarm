import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medicine_alarm/constants.dart';
import 'package:medicine_alarm/generated/l10n.dart';
import 'package:medicine_alarm/global_bloc.dart';
import 'package:medicine_alarm/models/medicine.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'time_utils.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final NotificationService _instance = NotificationService._internal();

  static const int dayNotification = 2;

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
        onDidReceiveNotificationResponse: onDidReceive, onDidReceiveBackgroundNotificationResponse: onDidReceiveBg);
  }

  onDidReceive(NotificationResponse notificationResponse) async {
    var id = notificationResponse.payload;
    if (id == null) return;
  }

  @pragma("vm:entry-point")
  onDidReceiveBg(NotificationResponse notificationResponse) async {
    var id = notificationResponse.payload;
    if (id == null) return;
    if(navigatorKey.currentContext != null) {
      print( Provider.of<GlobalBloc>(navigatorKey.currentContext!));
    }
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
            sound: RawResourceAndroidNotificationSound("sound"),
            playSound: true,
            // fullScreenIntent: true,
            ledOnMs: 1000,
            enableLights: true),
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
    if(isAll){
      days = ["1", "2", "3", "4", "5", "6", "7"];
    }
    for (var day in days) {
      for (TimeOfDay time in medicine.times ?? []) {
        var dateTime = TimeUtils.getDateTime(time);
        var id = int.parse('${medicine.id}$dayNotification$day${time.hour}');
        notificationIds.add(id);
        tz.TZDateTime txTime;
        if (nextTime == null || dateTime.isBefore(nextTime)) {
          txTime = TimeUtils.createTZDateTimeForNext(
              int.parse(day) + 7, time);
        } else {
          txTime = TimeUtils.createTZDateTimeForNext(int.parse(day), time);
        }

        print('zonedSchedule at $txTime $id');
        await notificationsPlugin.zonedSchedule(
          id,
          S.current.title_noti(
              TimeUtils.formatTimeOfDay(time: time) ?? "", medicine.getName),
          S.current.content_noti,
          txTime,
          notificationDetails(),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents:  DateTimeComponents.dayOfWeekAndTime,
          payload: medicine.id.toString(),
        );
      }
    }
    medicine.notificationIDs = notificationIds;
    bloc?.updateMedicine(medicine);
  }

  cancelAll(Medicine medicine) async {
    for (var id in medicine.notificationIDs ?? []) {
      await notificationsPlugin.cancel(id);
    }
  }

  Future<void> scheduleNextNotification(Medicine medicine) async {
    // var id = DateTime.now().weekday;
    // var txTime = TimeUtils.createTZDateTimeNext(medicine.getInterval);
    // await notificationsPlugin.zonedSchedule(
    //     id,
    //     S.current.title_noti(
    //         S.current.title_noti(
    //             TimeUtils.convertTime(TimeUtils.pattern_4, txTime) ?? "",
    //             medicine.getName),
    //         medicine.getName),
    //     S.current.content_noti,
    //     txTime,
    //     notificationDetails(),
    //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    //     uiLocalNotificationDateInterpretation:
    //         UILocalNotificationDateInterpretation.absoluteTime,
    //     matchDateTimeComponents: DateTimeComponents.dateAndTime);
  }

  void cancelNow() {
    var id = DateTime.now().weekday;
    notificationsPlugin.cancel(id);
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
