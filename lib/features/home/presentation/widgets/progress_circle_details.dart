import 'package:flutter/material.dart';
import 'package:task_project/core/util/custom_text_style.dart';
import 'package:task_project/core/widgets/progress_circle_widget.dart';

class ProgressCircleWithDetails extends StatelessWidget {
  const ProgressCircleWithDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         ProgressCircle(radius: 70.0, centerWidget: Text(
           "3/5",
           style: CustomTextStyle.progressWordsStyle,
         ), percent: 0.6,),
        Center(
          child: Text(
            "       60%\n Completed",
            style: CustomTextStyle.progressWordsStyle,
          ),
        )
      ],
    );
  }
}
