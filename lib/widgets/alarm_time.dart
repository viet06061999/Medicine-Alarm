import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicine_alarm/constants.dart';
import 'package:medicine_alarm/generated/l10n.dart';
import 'package:medicine_alarm/utils/noti_utils.dart';
import 'package:medicine_alarm/utils/time_utils.dart';

import 'select_time.dart';

class AlarmTime extends StatelessWidget {
  final Function(List<TimeOfDay>) onTime;
  final List<TimeOfDay> times;

  const AlarmTime({super.key, required this.onTime, required this.times});

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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Wrap(
            children: times
                .asMap()
                .map(
                  (index, time) {
                    return MapEntry(
                        index,
                        SelectTime(
                          onSelect: (value) {
                            if (index != 0 && index != times.length - 1) {
                              var startTime =
                                  TimeUtils.getDateTime(times.first);
                              var endTime = TimeUtils.getTimeIfNext(
                                  times.first, times.last, plusDay: true);
                              var timeGet = TimeUtils.getTimeIfNext(
                                  times.first, value ?? time);
                              if (timeGet.isAfter(endTime) ||
                                  timeGet.isBefore(startTime)) {
                                var startS = TimeUtils.formatTimeOfDay(
                                    time: times.first);
                                var endS = "";
                                if (TimeUtils.isNextDay(
                                    times.first, times.last)) {
                                  endS = S.current.time_next(
                                      TimeUtils.formatTimeOfDay(
                                              time: times.last) ??
                                          "");
                                } else {
                                  endS = TimeUtils.formatTimeOfDay(
                                          time: times.last) ??
                                      "";
                                }
                                NotificationService().openAlertBox(S.current
                                    .select_time_warning(startS ?? "", endS));
                                return;
                              }
                            }
                            if (index != -1) {
                              times[index] = value ?? time;
                            }
                            List<TimeOfDay> timesResult = [];
                            if (times.length == 1) {
                              timesResult.add(times.removeAt(0));
                            } else if (times.length >= 2) {
                              timesResult.add(times.removeAt(0));
                              timesResult.add(times.removeLast());
                            }
                            times.sort((a, b) =>
                                a.hour * 60 +
                                a.minute -
                                (b.hour * 60 + b.minute));
                            timesResult.insertAll(1, times);
                            onTime(timesResult);
                          },
                          time: time,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: kPrimaryColor),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            margin: const EdgeInsets.only(left: 16, top: 8),
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
                        ));
                  },
                )
                .values
                .toList(),
          ),
        ),
      ]),
    );
  }
}
