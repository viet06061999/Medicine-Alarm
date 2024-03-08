import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medicine_alarm/constants.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime startTime;
  final DateTime? nextTime;
  final bool done;
  final Function onCount;

  const CountdownTimer(
      {super.key,
      required this.startTime,
      required this.nextTime,
      required this.onCount,
      required this.done});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    calculateNextTime();
    startTimer();
  }

  void calculateNextTime() {
    if (widget.nextTime == null) {
      return;
    }
    Duration remainingDuration = widget.nextTime!.difference(DateTime.now());
    if (remainingDuration.inSeconds % 10 == 0) {
      widget.onCount.call();
    }
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        calculateNextTime();
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String formatDuration() {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    if (widget.done ||
        widget.nextTime == null ||
        widget.nextTime?.isBefore(widget.startTime) == true ||
        widget.nextTime?.isBefore(DateTime.now()) == true) {
      return "00:00:00";
    }

    Duration duration = widget.nextTime!.difference(DateTime.now());

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    String remainingTime = formatDuration();

    return Text(
      remainingTime,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: kOrange, fontWeight: FontWeight.bold),
    );
  }
}
