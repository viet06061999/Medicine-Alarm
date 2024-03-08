import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicine_alarm/constants.dart';
import 'package:sizer/sizer.dart';

class ItemTime extends StatelessWidget {
  const ItemTime({
    super.key,
    required this.context,
    required this.icon,
    required this.title,
    required this.child,
  });

  final BuildContext context;
  final String icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 50.w,
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  child: SvgPicture.asset(
                    icon,
                    height: 20,
                    width: 20,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: kOrange),
                ),
              ],
            ),
          ),
          const SizedBox(),
          child,
        ],
      ),
    );
  }
}
