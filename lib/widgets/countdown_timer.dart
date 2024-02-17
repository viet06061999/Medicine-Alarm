import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medicine_alarm/constants.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime startTime;
  final int durationInHours;
  final Function onCount;

  CountdownTimer({required this.startTime, required this.durationInHours, required this.onCount});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late DateTime nextTime;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    calculateNextTime();
    startTimer();
  }

  void calculateNextTime() {
    nextTime = widget.startTime.add(Duration(hours: widget.durationInHours));
    Duration remainingDuration = nextTime.difference(DateTime.now());
    if(remainingDuration.inSeconds % 10 == 0){
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

  String formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }
    if(duration.isNegative){
      return "00:00:00";
    }
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    Duration remainingDuration = nextTime.difference(DateTime.now());
    String remainingTime = formatDuration(remainingDuration);

    return Text(
      remainingTime,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: kOrange, fontWeight: FontWeight.bold),
    );
  }
}