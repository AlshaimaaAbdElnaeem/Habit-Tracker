import 'package:flutter/material.dart';

import '../util/color.dart';

GestureDetector checkStatus(
    {required status,
    required Color textColor,
    required Color statusColor,
    required Icon completeIcon}) {
  return GestureDetector(
    onTap: () {
      statusColor = AppColors.primaryColor;
      status = "Completed";
      textColor = Colors.white;
      completeIcon = const Icon(
        Icons.check_circle_rounded,
        color: Colors.white,
      );
    },
    child: Container(
      margin: const EdgeInsets.only(top: 8.0),
      width: 100,
      height: 35,
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          completeIcon,
          Text(
            status,
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    ),
  );
}
