import 'dart:math';

import 'package:flutter/material.dart';
import 'package:medicine_alarm/utils/time_utils.dart';

class Medicine {
  final int id;
  List<int>? notificationIDs;
  final String? medicineName;
  final String? listPill;
  final String? description;
  final int? number;
  final TimeOfDay startTime;
  final TimeOfDay bedTime;
  final List<String> days;
  List<DateTime>? pickTimes;
  List<TimeOfDay> times;
  bool isDoneOfDay;

  Medicine(this.id, this.days,
      {this.notificationIDs,
      this.medicineName,
      this.listPill,
      this.description,
      required this.startTime,
      required this.bedTime,
      this.number,
      this.pickTimes,
      this.isDoneOfDay = false,
      required this.times});

  //geters
  String get getName => medicineName!;

  List<TimeOfDay> get getTimes => times ?? [];

  DateTime? get last =>
      pickTimes != null && pickTimes!.isNotEmpty ? pickTimes!.last : null;

  DateTime? get next {

    // if (times.isNotEmpty) {
    //   DateTime now = DateTime.now();
    //   Duration shortestDuration =
    //       const Duration(days: 365); // Giả sử một khoảng thời gian tối đa
    //
    //   for (var i = 0; i < times.length; i++) {
    //     var time = times[i];
    //     DateTime dateTime =
    //         DateTime(now.year, now.month, now.day, time.hour, time.minute);
    //     if (dateTime.isAfter(now) &&
    //         dateTime.difference(now) < shortestDuration &&
    //         i >= (pickTimes?.length ?? 0)) {
    //       shortestDuration = dateTime.difference(now);
    //       nextTime = dateTime;
    //     }
    //   }
    // }
    if (pickTimes == null || pickTimes!.isEmpty) {
      return TimeUtils.getDateTime(times.first);
    } else {
     var index = pickTimes?.length ?? -1;
     if(index != -1){
       return TimeUtils.getDateTime(times[index]);
     }
    }
    return null;
  }

  int get totalTime {
    if (next != null && last != null) {
      Duration duration = next!.difference(last!);
      return duration.inMilliseconds;
    }
    return 1;
  }

  bool getActive() {
    var isAll = days.length == 1 && days[0] == "0";
    var isToday = days.contains(DateTime.now().weekday.toString());
    return isAll || isToday;
  }

  TimeOfDay get getStartTime => startTime;

  String get getStartTimeStr =>
      "${startTime.hour <= 9 ? "0${startTime.hour}" : startTime.hour}:${startTime.minute <= 9 ? "0${startTime.minute}" : startTime.minute}";

  String get geBedTimeStr =>
      "${bedTime.hour <= 9 ? "0${bedTime.hour}" : bedTime.hour}:${bedTime.minute <= 9 ? "0${bedTime.minute}" : bedTime.minute}";

  List<dynamic> get getIDs => notificationIDs!;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ids': notificationIDs,
      'name': medicineName,
      'days': days,
      'number': number,
      'times': times
          .map((e) =>
              "${e.hour <= 9 ? "0${e.hour}" : e.hour}:${e.minute <= 9 ? "0${e.minute}" : e.minute}")
          .toList(),
      'start':
          "${startTime.hour <= 9 ? "0${startTime.hour}" : startTime.hour}:${startTime.minute <= 9 ? "0${startTime.minute}" : startTime.minute}",
      'bedTime':
          "${bedTime.hour <= 9 ? "0${bedTime.hour}" : bedTime.hour}:${bedTime.minute <= 9 ? "0${bedTime.minute}" : bedTime.minute}",
      'pickTimes': pickTimes?.map((e) {
        return TimeUtils.convertTime(TimeUtils.pattern_3, e);
      }).toList(),
      'isDoneOfDay': isDoneOfDay
    };
  }

  factory Medicine.fromJson(Map<String, dynamic> parsedJson) {
    return Medicine(parsedJson['id'], List<String>.from(parsedJson['days']),
        notificationIDs: parsedJson['ids'] != null
            ? List<int>.from(parsedJson['ids']).map((e) => e).toList()
            : null,
        medicineName: parsedJson['name'],
        number: parsedJson['number'],
        startTime: TimeUtils.parseTimeOfDay(parsedJson['start']),
        bedTime: TimeUtils.parseTimeOfDay(parsedJson['bedTime']),
        pickTimes: parsedJson['pickTimes'] != null
            ? List<String>.from(parsedJson['pickTimes'])
                .map((e) => TimeUtils.parseTime(TimeUtils.pattern_3, e))
                .toList()
            : null,
        isDoneOfDay: parsedJson['isDoneOfDay'],
        times: parsedJson['times'] != null
            ? List<String>.from(parsedJson['times'])
                .map((e) => TimeUtils.parseTimeOfDay(e))
                .toList()
            : []);
  }

  bool doneToday() {
    var isBefore = last == null;
    var pickDone = (pickTimes?.length ?? 0) >= (number ?? 0);
    var lastTime = times.isNotEmpty
        ? TimeUtils.getDateTime(times.last)
        : DateTime.now().subtract(const Duration(seconds: 2));
    var isAfterLast = DateTime.now().isAfter(lastTime);
    return !isBefore & (pickDone || isDoneOfDay || isAfterLast);
  }
}
