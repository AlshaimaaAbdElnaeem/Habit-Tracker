import 'package:flutter/material.dart';
import 'package:task_project/features/home/presentation/widgets/list_of_habit_cards.dart';
import 'package:task_project/features/home/presentation/widgets/task_item.dart';
import '../../../../core/util/color.dart';
import '../../../../core/util/custom_text_style.dart';
import '../../../../core/util/methods.dart';
import '../../../../core/util/strings.dart';
import '../widgets/add_new_plans.dart';

import '../widgets/progress_circle_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(125.0),
        child: ClipPath(
          clipper: CustomShapeClipper(),
          child: AppBar(
            backgroundColor: AppColors.primaryColor,
            title: Row(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 50,
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppStrings.appName,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        //هجربها في ال metting
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 0.0),
          child: Column(
            children: [
              Text(
                AppStrings.dailyTask,
                style: CustomTextStyle.titleStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.habitTitle,
                      style: CustomTextStyle.habitTitle,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          AppStrings.viewAll,
                          style: CustomTextStyle.viewAll,
                        )),
                  ],
                ),
              ),
              const ListOfHabitCards(),
              const AddNewPlans(),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: ProgressCircleWithDetails(),
                  ),
                  Column(
                    children: [
                      TaskItem(taskName: "Morning cicling", isCompleted: true),
                      TaskItem(taskName: "Morning cicling", isCompleted: true),
                      TaskItem(taskName: "Morning cicling", isCompleted: false),
                      TaskItem(taskName: "Morning cicling", isCompleted: true),
                      TaskItem(taskName: "Morning cicling", isCompleted: false),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
