import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicine_alarm/constants.dart';
import 'package:medicine_alarm/generated/l10n.dart';
import 'package:medicine_alarm/widgets/day_picker/select_day.dart';

class SelectDayWeek extends StatelessWidget {
  final List<String> days;
  final bool enable;
  final Function(List<String>) onSelect;

  const SelectDayWeek(
      {super.key,
      required this.enable,
      required this.onSelect,
      this.days = const ["0"]});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          SvgPicture.asset(
            "assets/icons/monthly-icon.svg",
            height: 24,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            S.current.day_of_week,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: kOrange),
          ),
        ],
      ),
      const SizedBox(
        height: 4,
      ),
      SelectWeekDays(
        fontSize: 13,
        padding: 24,
        enable: enable,
        fontWeight: FontWeight.w500,
        days: days,
        onSelect: (values) {
          // <== Callback to handle the selected days
          onSelect(values);
        },
      )
    ]);
  }
}
