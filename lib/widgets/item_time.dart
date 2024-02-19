import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicine_alarm/constants.dart';

class ItemTime extends StatelessWidget {

  const ItemTime({
    super.key,
    required this.context,
    required this.icon,
    required this.title,
    required this.width,
    required this.child,
  });

  final BuildContext context;
  final String icon;
  final String title;
  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          icon,
          height: 24,
        ),
        const SizedBox(
          width: 8,
        ),
        SizedBox(
          width: width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: kOrange),
              ),
              const SizedBox(
                height: 8,
              ),
              child ?? const SizedBox()
            ],
          ),
        ),
      ],
    );
  }
}
