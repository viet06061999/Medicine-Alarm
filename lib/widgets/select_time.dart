import 'package:flutter/material.dart';

class SelectTime extends StatelessWidget {
  final Function(TimeOfDay?) onSelect;
  final Widget child;
  final TimeOfDay? time;

  const SelectTime(
      {super.key, required this.onSelect, required this.child, this.time});

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context, initialTime: time ?? TimeOfDay.now());

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
