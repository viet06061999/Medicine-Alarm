import 'package:flutter/material.dart';
import 'package:medicine_alarm/utils/time_utils.dart';

class Medicine {
  final String id;
  final List<dynamic>? notificationIDs;
  final String? medicineName;
  final int? dosage;
  final String? medicineType;
  final int? interval;
  final TimeOfDay startTime;
  List<DateTime>? pickTimes;

  Medicine(
    this.id, {
    this.notificationIDs,
    this.medicineName,
    this.dosage,
    this.medicineType,
    required this.startTime,
    this.interval,
    this.pickTimes,
  });

  //geters
  String get getName => medicineName!;

  int get getDosage => dosage!;

  String get getType => medicineType!;

  int get getInterval => interval!;

  TimeOfDay get getStartTime => startTime!;

  List<dynamic> get getIDs => notificationIDs!;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ids': notificationIDs,
      'name': medicineName,
      'dosage': dosage,
      'type': medicineType,
      'interval': interval,
      'start':
          "${startTime.hour <= 9 ? "0" : startTime.hour}:${startTime.minute <= 9 ? "0" : startTime.minute}",
      'pickTimes': pickTimes?.map((e) {
        return TimeUtils.convertTime(TimeUtils.pattern_3, e);
      }).toList(),
    };
  }

  factory Medicine.fromJson(Map<String, dynamic> parsedJson) {
    return Medicine(
      parsedJson['id'],
      notificationIDs: parsedJson['ids'],
      medicineName: parsedJson['name'],
      dosage: parsedJson['dosage'],
      medicineType: parsedJson['type'],
      interval: parsedJson['interval'],
      startTime: TimeUtils.parseTimeOfDay(parsedJson['start']),
      pickTimes: parsedJson['pickTimes'] != null
          ? List<String>.from(parsedJson['pickTimes'])
              .map((e) => TimeUtils.parseTime(TimeUtils.pattern_3, e))
              .toList()
          : null,
    );
  }
}
