import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:task_project/core/util/color.dart';
import 'package:task_project/core/util/custom_text_style.dart';

class ProgressCircle extends StatelessWidget {
  const ProgressCircle({
    super.key, required this.radius, required this.centerWidget, required this.percent,
  });
final double radius ;
final Widget centerWidget;
final double percent ;
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: radius,
      lineWidth: 10.0,
      percent:percent,
      reverse: true,
      center:centerWidget,
      progressColor: AppColors.primaryColor,
      backgroundColor: Colors.grey.withOpacity(0.5),
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
