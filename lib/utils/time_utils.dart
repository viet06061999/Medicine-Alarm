import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeUtils {
  static const String pattern_1 = "E, dd/MM/yy'";
  static const String pattern_2 = "HH:mm:ss'";
  static const String pattern_3 = "dd/MM/yyyy HH:mm:sss";
  static const String pattern_4 = "HH:mm'";

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
    DateTime todayWithTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return dateTime.isBefore(todayWithTime);
  }
}
