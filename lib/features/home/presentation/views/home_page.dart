import 'package:flutter/material.dart';
import 'package:task_project/features/home/presentation/widgets/list_of_habit_cards.dart';
import 'package:task_project/features/home/presentation/widgets/task_item.dart';
import '../../../../core/util/color.dart';
import '../../../../core/util/custom_text_style.dart';
import '../../../../core/util/methods.dart';
import '../../../../core/util/strings.dart';
import '../widgets/add_new_plans.dart';
import 'package:task_project/features/navbar/presentation/widget/navbar_project.dart';


import '../widgets/progress_circle_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Variable to track the current index

  final List<Widget> _pages = [
    // List of pages corresponding to the navigation items
    const HomePageContent(),
    Container(color: Colors.red), // Placeholder for second page
    Container(color: Colors.green), // Placeholder for third page
  ];

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
      body: _pages[_currentIndex], // Show the current page based on the index
      bottomNavigationBar: NavBarProject(
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the current index when the nav item is tapped
          });
        },
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    TaskItem(taskName: "Morning cycling", isCompleted: true),
                    TaskItem(taskName: "Afternoon cycling", isCompleted: false),
                    TaskItem(taskName: "Evening cycling", isCompleted: true),
                    TaskItem(taskName: "Night cycling", isCompleted: false),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}