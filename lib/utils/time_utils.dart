import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class TimeUtils {
  static const String pattern_1 = "E, dd/MM/yy'";
  static const String pattern_2 = "HH:mm:ss'";
  static const String pattern_3 = "dd/MM/yyyy HH:mm:sss";
  static const String pattern_4 = "HH:mm";

  static String convertTime(String format, DateTime dateTime) {
    return DateFormat(format).format(dateTime);
  }

  static DateTime parseTime(String format, String dateTime) {
    return DateFormat(format).parse(dateTime);
  }

  static TimeOfDay parseTimeOfDay(String time) {
    return TimeOfDay.fromDateTime(DateTime.parse('2022-01-01 $time'));
  }

  static bool isBeforeStart(DateTime dateTime, TimeOfDay time) {
    DateTime now = DateTime.now();
    DateTime todayWithTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return dateTime.isBefore(todayWithTime);
  }

  static DateTime getDateTime(TimeOfDay time) {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }

  static bool isAfterEnd(
      TimeOfDay start, TimeOfDay end, int duration, int count) {
    var last = TimeOfDay(
        hour: start.hour + duration * (count - 1), minute: start.minute);
    var lastMinute = last.hour * 60 + last.minute;
    var endMinute = end.hour * 60 + end.minute;
    return lastMinute > endMinute;
  }

  static bool isValidStart(TimeOfDay start, TimeOfDay end) {
    var startMinute = start.hour * 60 + start.minute;
    var endMinute = end.hour * 60 + end.minute;
    return endMinute > startMinute;
  }

  static tz.TZDateTime createTZDateTimeForDayOfWeek(
      int dayOfWeek, TimeOfDay timeOfDay) {
    final DateTime now = DateTime.now();
    final int daysToAdd = (dayOfWeek - now.weekday + 7) % 7;
    return tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day + daysToAdd,
      timeOfDay.hour,
      timeOfDay.minute,
    );
  }

  static tz.TZDateTime createTZDateTimeForNext(
      int days, TimeOfDay timeOfDay) {
    final DateTime now = DateTime.now();
    return tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day + days,
      timeOfDay.hour,
      timeOfDay.minute,
    );
  }

  static tz.TZDateTime createTZDateTimeNext(int next) {
    final DateTime now = DateTime.now();
    return tz.TZDateTime.from(now.add(Duration(hours: next)), tz.local);
  }

  static tz.TZDateTime createTZDateTimeNextMinute(int next) {
    final DateTime now = DateTime.now();
    return tz.TZDateTime.from(now.add(Duration(minutes: next)), tz.local);
  }

  static String? formatTimeOfDay({TimeOfDay? time, String? defaultText}) {
    if (time == null) {
      return defaultText;
    }
    return "${time.hour <= 9 ? "0${time.hour}" : time.hour}:${time.minute <= 9 ? "0${time.minute}" : time.minute}";
  }
}
