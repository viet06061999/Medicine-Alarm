import 'package:flutter/material.dart';

class SelectTime extends StatelessWidget {
  final Function(TimeOfDay?) onSelect;
  final Widget child;
  final TimeOfDay? time;

  const SelectTime(
      {super.key, required this.onSelect, required this.child, this.time});

  void _selectTime(BuildContext context) async {
   var picked = await showTimePicker(
      context: context,
      initialTime:  time ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null && picked != time) {
      onSelect(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectTime(context);
      },
      child: child,
    );
  }
}
