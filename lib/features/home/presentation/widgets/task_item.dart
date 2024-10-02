import 'package:flutter/material.dart';
import 'package:task_project/core/util/color.dart';
import 'package:task_project/core/util/custom_text_style.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(
      {super.key, required this.taskName, required this.isCompleted});
  final String taskName;
  final bool isCompleted;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.error,
            color: isCompleted ? AppColors.primaryColor : Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: Text(
              taskName,
              style: CustomTextStyle.progressWordsStyle,
            ),
          )
        ],
      ),
    );
  }
}
