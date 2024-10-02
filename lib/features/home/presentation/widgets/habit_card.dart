import 'package:flutter/material.dart';
import 'package:task_project/core/util/color.dart';
import 'package:task_project/core/util/custom_text_style.dart';
import 'package:task_project/core/util/strings.dart';
import 'package:task_project/features/home/presentation/widgets/image_and_next_button_in_card.dart';

class HabitCard extends StatefulWidget {
  const HabitCard({super.key});

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  Icon completeIcon = Icon(Icons.error, color: AppColors.primaryColor);
  String status = "Pending";
  Color statusColor = Colors.white;
  Color textColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
              colors: [AppColors.cardColor1, AppColors.cardColor2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppStrings.taskName,
                  style: CustomTextStyle.titleStyle,
                ),
                Text(
                  AppStrings.time,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Day 10",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      statusColor = AppColors.primaryColor;
                      status = "Completed";
                      textColor = Colors.white;
                      completeIcon = const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.white,
                      );
                    });
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
                ),
              ],
            ),
            const ImageAndNextButton()
          ],
        ),
      ),
    );
  }
}
