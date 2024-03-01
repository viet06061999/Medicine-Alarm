import 'package:flutter/material.dart';
import 'package:medicine_alarm/constants.dart';
import 'package:medicine_alarm/generated/l10n.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.current.no_alarm,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
        ),
        Text(
          S.current.create_new,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Image.asset("assets/images/empty.png")
      ],
    );
  }
}
