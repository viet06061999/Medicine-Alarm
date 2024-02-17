import 'package:flutter/material.dart';
import 'package:medicine_alarm/constants.dart';
import 'package:medicine_alarm/generated/l10n.dart';

import 'model/day_in_week.dart';

class SelectWeekDays extends StatefulWidget {
  /// [onSelect] callBack to handle the Selected days
  final Function onSelect;

  /// List of days of type `DayInWeek`
  final List<String> days;

  /// [fontWeight] - property to change the weight of selected text
  final FontWeight? fontWeight;

  /// [fontSize] - property to change the size of selected text
  final double? fontSize;

  /// [selectedDayTextColor] - property to change the color of text when the day is selected.
  final Color? selectedDayTextColor;

  /// [unSelectedDayTextColor] - property to change the text color when the day is not selected.
  final Color? unSelectedDayTextColor;

  /// [padding] property  to handle the padding between the container and buttons by default it is 8.0
  final double padding;

  final bool enable;

  /// The property that can be used to specify the [width] of the [SelectWeekDays] container.
  /// By default this property will take the full width of the screen.
  final double? width;

  /// `SelectWeekDays` takes a list of days of type `DayInWeek`.
  /// `onSelect` property will return `list` of days that are selected.
  const SelectWeekDays({
    required this.onSelect,
    this.fontWeight,
    this.fontSize,
    this.selectedDayTextColor,
    this.unSelectedDayTextColor,
    this.padding = 8.0,
    this.width,
    required this.days,
    this.enable = false,
    super.key,
  });

  @override
  SelectWeekDaysState createState() => SelectWeekDaysState(days);
}

class SelectWeekDaysState extends State<SelectWeekDays> {
  SelectWeekDaysState(List<String> days) : selectedDays = days;

  // list to insert the selected days.
  List<String> selectedDays = [];

  // list of days in a week.
  final List<DayInWeek> _daysInWeek = [
    DayInWeek(
      S.current.all,
      dayKey: S.current.all,
    ),
    DayInWeek(
      S.current.sun,
      dayKey: S.current.sun,
    ),
    DayInWeek(
      S.current.mon,
      dayKey: S.current.mon,
    ),
    DayInWeek(S.current.tue, dayKey: S.current.tue),
    DayInWeek(
      S.current.wed,
      dayKey: S.current.wed,
    ),
    DayInWeek(
      S.current.thu,
      dayKey: S.current.thu,
    ),
    DayInWeek(
      S.current.fri,
      dayKey: S.current.fri,
    ),
    DayInWeek(
      S.current.sat,
      dayKey: S.current.sat,
    ),
  ];

  @override
  void initState() {
    for (var element in _daysInWeek) {
      if (selectedDays.contains(element.dayKey)) {
        element.isSelected = true;
      }
    }
    super.initState();
  }

  void _getSelectedWeekDays(bool isSelected, String day) {
    selectedDays = [];
    for (DayInWeek dayInWeek in _daysInWeek) {
      if (dayInWeek.isSelected) {
        selectedDays.add(dayInWeek.dayKey);
      }
    }
    // [onSelect] is the callback which passes the Selected days as list.
    widget.onSelect(selectedDays.toList());
  }

// Handler to change the text color when the button is pressed and not pressed.
  Color? _handleTextColor(bool onSelect) {
    Color? textColor = kPrimaryColor;
    if (onSelect == true) {
      if (widget.selectedDayTextColor == null) {
        textColor = Colors.white;
      } else {
        textColor = widget.selectedDayTextColor;
      }
    } else if (onSelect == false) {
      if (widget.unSelectedDayTextColor == null) {
        textColor = kPrimaryColor;
      } else {
        textColor = widget.unSelectedDayTextColor;
      }
    }
    return textColor;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.padding),
        child: Wrap(
          children: _daysInWeek.map(
            (day) {
              return RawMaterialButton(
                constraints: const BoxConstraints(minWidth: 24),
                fillColor: day.isSelected ? kPrimaryColor : kBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                onPressed: widget.enable
                    ? () {
                        setState(() {
                          if (day.dayKey == S.current.all) {
                            for (DayInWeek dayInWeek in _daysInWeek) {
                              dayInWeek.isSelected = false;
                            }
                          } else {
                            _daysInWeek[0].isSelected = false;
                          }
                          day.toggleIsSelected();
                        });
                        _getSelectedWeekDays(day.isSelected, day.dayKey);
                      }
                    : null,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                  child: Text(
                    day.dayName,
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      fontWeight: widget.fontWeight,
                      color: _handleTextColor(day.isSelected),
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
