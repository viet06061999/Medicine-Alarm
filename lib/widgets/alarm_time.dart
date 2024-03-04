import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicine_alarm/constants.dart';
import 'package:medicine_alarm/generated/l10n.dart';
import 'package:medicine_alarm/utils/time_utils.dart';
import 'package:medicine_alarm/widgets/day_picker/select_day.dart';

import 'select_time.dart';

class AlarmTime extends StatefulWidget {
  final Function(List<TimeOfDay>) onTime;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final int count;
  final List<TimeOfDay>? times;

  const AlarmTime(
      {super.key,
      required this.onTime,
      required this.startTime,
      required this.endTime,
      required this.count,
      this.times});

  @override
  State<AlarmTime> createState() => _AlarmTimeState();
}

class _AlarmTimeState extends State<AlarmTime> {
  List<TimeOfDay> times = [];
  bool _first = true;

  List<TimeOfDay> calculateAlarmTimes() {
    if (widget.count == 0) {
      return [];
    }
    final List<TimeOfDay> alarmTimes = [];

    final int totalMinutes = _calculateTotalMinutes();
    final int interval =
        totalMinutes ~/ (widget.count - 1); // Chia đều khoảng thời gian

    TimeOfDay currentTime = widget.startTime;
    alarmTimes.add(widget.startTime);
    for (int i = 0; i < widget.count - 2; i++) {
      currentTime = _addMinutes(currentTime, interval);
      alarmTimes.add(currentTime);
    }
    if (alarmTimes.length < widget.count) {
      alarmTimes.add(widget.endTime);
    }
    return alarmTimes;
  }

  int _calculateTotalMinutes() {
    final int startMinutes =
        widget.startTime.hour * 60 + widget.startTime.minute;
    final int endMinutes = widget.endTime.hour * 60 + widget.endTime.minute;
    return endMinutes - startMinutes;
  }

  TimeOfDay _addMinutes(TimeOfDay time, int minutes) {
    final int totalMinutes = time.hour * 60 + time.minute + minutes;
    final int hours = totalMinutes ~/ 60;
    final int remainingMinutes = totalMinutes % 60;
    return TimeOfDay(hour: hours, minute: remainingMinutes);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_first && widget.times != null) {
      times = widget.times!;
      _first = false;
    } else {
      times = calculateAlarmTimes();
    }
    times.sort((a, b) => a.hour * 60 + a.minute - (b.hour * 60 + b.minute));
    widget.onTime(times);
  }

  @override
  void didUpdateWidget(covariant AlarmTime oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_first && widget.times != null) {
      times = widget.times!;
      _first = false;
    } else {
      times = calculateAlarmTimes();
    }
    //todo check
    times.sort((a, b) => a.hour * 60 + a.minute - (b.hour * 60 + b.minute));
    widget.onTime(times);
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      replacement: const SizedBox(),
      visible: times.isNotEmpty,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            SvgPicture.asset(
              "assets/icons/alarm-icon.svg",
              height: 24,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              S.current.take_time,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: kOrange),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Wrap(
            children: times.map(
              (time) {
                return SelectTime(
                  onSelect: (value) {
                    setState(() {
                      var index = times.indexOf(time);
                      if (index != -1) {
                        times[index] = value ?? time;
                      }
                    });
                    widget.onTime(times);
                  },
                  time: time,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: kPrimaryColor),
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    margin: const EdgeInsets.only(left: 16),
                    child: Text(
                      TimeUtils.formatTimeOfDay(
                              time: time, defaultText: "00:00") ??
                          "",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ]),
    );
  }
}
