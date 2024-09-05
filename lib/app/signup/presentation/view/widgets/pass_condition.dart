import 'package:flutter/material.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import 'package:tampay_mobile/theme/color_data.dart';

class PassCondition extends StatelessWidget {
  final String title;
  final bool isMet;

  const PassCondition({
    super.key,
    required this.title,
    required this.isMet,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        getSvgImage(
          "check_circle.svg",
          color: isMet ? successGreen : grey400Color,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 6),
        getCustomFont(
          title,
          14.5,
          isMet ? successGreen : grey400Color,
          1,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
