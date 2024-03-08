import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicine_alarm/constants.dart';
import 'package:medicine_alarm/generated/l10n.dart';
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
            children: times.map(
              (time) {
                return SelectTime(
                  onSelect: (value) {
                    var index = times.indexOf(time);
                    if (index != -1) {
                      times[index] = value ?? time;
                    }
                    times.sort((a, b) =>
                        a.hour * 60 + a.minute - (b.hour * 60 + b.minute));
                    onTime(times);
                  },
                  time: time,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: kPrimaryColor),
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
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
                );
              },
            ).toList(),
          ),
        ),
      ]),
    );
  }
}
