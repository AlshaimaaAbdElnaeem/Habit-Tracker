import 'package:flutter/material.dart';
import 'package:task_project/core/util/custom_text_style.dart';
import 'package:task_project/features/home/presentation/widgets/progress_circle_widget.dart';

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
        const ProgressCircle(),
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
