import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:task_project/core/util/color.dart';
import 'package:task_project/core/util/custom_text_style.dart';

class ProgressCircle extends StatelessWidget {
  const ProgressCircle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 70.0,
      lineWidth: 10.0,
      percent: 0.6,
      reverse: true,
      center: Text(
        "3/5",
        style: CustomTextStyle.progressWordsStyle,
      ),
      progressColor: AppColors.primaryColor,
      backgroundColor: Colors.grey.withOpacity(0.5),
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
