import 'package:flutter/material.dart';
import 'package:task_project/core/util/color.dart';

abstract class CustomTextStyle {
  static final titleStyle = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static final habitTitle = TextStyle(
    color: Colors.grey,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static final viewAll = TextStyle(
    fontSize: 14,
    color: AppColors.primaryColor,
    fontWeight: FontWeight.bold,
  );
  static final progressWordsStyle = TextStyle(
    fontWeight: FontWeight.bold,
  );
}
