import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicine_alarm/constants.dart';
import 'package:sizer/sizer.dart';

class TextFieldWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String? content;
  final int line;
  final TextEditingController? controller;
  final bool isEditing;
  final bool isRequired;
  final double? width;

  const TextFieldWidget(this.icon, this.title, this.content, this.controller,
      {super.key,
      this.line = 1,
      this.isEditing = false,
      this.isRequired = false,
      this.width});

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
          width: 12,
        ),
        SizedBox(
          width: width ?? 80.w,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: kOrange),
                    ),
                    TextSpan(
                      text: isRequired ? " *" : "",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: kPrimaryColor,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              FocusScope(
                child: TextFormField(
                  controller: controller,
                  readOnly: !isEditing,
                  maxLines: null,
                  minLines: line,
                  decoration: InputDecoration(
                    hintText: content ?? title,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: kHint),
                    enabledBorder: outLineBorder,
                    disabledBorder: outLineBorder,
                    focusedBorder: outLineBorder,
                    errorBorder: outLineBorder,
                    focusedErrorBorder: outLineBorder,
                    filled: true,
                    fillColor: kBackground,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: kPrimaryColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
