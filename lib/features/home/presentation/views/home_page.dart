import 'package:flutter/material.dart';
import 'package:task_project/features/Profile/privacy_page.dart';
import 'package:task_project/features/Profile/profile_page.dart';
import 'package:task_project/features/home/presentation/widgets/list_of_habit_cards.dart';
import 'package:task_project/features/home/presentation/widgets/task_item.dart';
import 'package:task_project/main.dart';
import '../../../../core/util/color.dart';
import '../../../../core/util/custom_text_style.dart';
import '../../../../core/util/methods.dart';
import '../../../../core/util/strings.dart';
import '../../../report/presentation/views/report_page.dart';
import '../widgets/add_new_plans.dart';
import 'package:task_project/features/navbar/presentation/widget/navbar_project.dart';
import '../widgets/progress_circle_details.dart';


void onThemeChanged(bool isDarkMode) {
  themeNotifier.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.userEmail});
final String userEmail ;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List<Widget> _pages;
  int _currentIndex = 0; // Variable to track the current index
@override
  void initState() {
    _pages = [
    HomePageContent(userEmail:widget.userEmail),
    ReportPage(),
    ProfilePage(onThemeChanged: onThemeChanged), // تمرير الدالة
    PrivacyPolicyPage(),
    // Placeholder for third page
  ];
    super.initState();
  }

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
      body:_pages[_currentIndex], // Show the current page based on the index
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
  const HomePageContent({super.key, required this.userEmail});
final String userEmail ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                 AddNewHabit(userEmail:userEmail),
              ],
            ),
          ),
          const Expanded(child: ListOfHabitCards()),
        ],
      ),
    );
  }
}
