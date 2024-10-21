import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/Habit_firebase.dart';
import 'package:task_project/features/home/data/habit_cubit.dart';
import 'package:task_project/features/home/data/habit_states.dart';

import '../../../../core/widgets/progress_circle_widget.dart';

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ReportPageCall();
  }
}

class ReportPageCall extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPageCall> {
  final List<String> completedTasks = [];
  final List<String> incompleteTasks = [];
   List<Habit> allHabits = [];

  double _progressValue = 0.0; // Initial progress value

  @override
  void initState() {
    super.initState();
    _calculateProgress();
  }

  // Calculate progress based on completed tasks
  void _calculateProgress() {
    int totalTasks = completedTasks.length + incompleteTasks.length;
    int completedCount = completedTasks.length;

    if (totalTasks > 0) {
      _progressValue = completedCount / totalTasks;
    } else {
      _progressValue = 0.0; // Avoid division by zero
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), //the height of the AppBar
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Middle Text (Report)
              Text(
                'Today\'s report',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Card with circular progress indicator and tasks
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0), // padding inside the card
                child: Column(
                  children: [
                    // Circular Progress Indicator in the center
                    Stack(
                      alignment:
                      Alignment.center, // Align children in the center
                      children: [
                        Container(
                          width: 110,
                          // Width of the circular progress indicator
                          height: 110,
                          // Height of the circular progress indicator
                          child: CircularProgressIndicator(
                            value: _progressValue,
                            strokeWidth: 10,
                            // Stroke width
                            backgroundColor: Colors.grey[300],
                            valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        ),
                        // Image inside the circular progress
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/images/cup.png', // Cup image
                                width: 70, // Increase image width
                                height: 70, // Increase image height
                                fit: BoxFit.cover,
                              ),
                            ),
                           const SizedBox(height: 5),
                            // Space between image and percentage
                            // Percentage text
                            Text(
                              '${(_progressValue * 100).toStringAsFixed(0)}%',
                              // Display percentage
                              style:const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20), // Space between image and tasks
                    // Row for completed and incomplete tasks
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Completed tasks on the left
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...completedTasks.map((task) => Row(
                                children: [
                                  const Icon(Icons.check_circle,
                                      color: Colors.green, size: 16),
                                  // Reduce icon size
                                  const SizedBox(width: 5),
                                  Text(
                                    task,
                                    style:const TextStyle(
                                        fontSize:
                                        10), // Decrease task text size
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ), // Incomplete tasks on the right
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ...incompleteTasks.map((task) => Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    task,
                                    style:const TextStyle(
                                        fontSize:
                                        12), // Decrease task text size
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(Icons.radio_button_unchecked,
                                      color: Colors.red, size: 16),
                                  // Reduce icon size
                                ],
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Space between progress card and list
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                child:const Text(
                  "History",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),

            // List of days with progress percentage
            BlocBuilder<HabitCubit, HabitStates>(
              builder: (context , state) {
                if (state is HabitsLoaded){
                  allHabits = state.habits;
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: allHabits.length,
                    itemBuilder: (context, index) {
                      int completedDaysForHabit = 0;

                      int daysSinceHabitCreation =
                          DateTime.now().difference(allHabits[index].createdAt.toDate()).inDays;

                      // Safely loop through all days since habit creation
                      for (int i = daysSinceHabitCreation; i > 0; i--) {
                        if (allHabits[index].isCompleted) {
                          completedDaysForHabit++;
                        }
                      }

                      // Calculate progress with a safe check
                      double habitProgress = daysSinceHabitCreation > 0
                          ? (completedDaysForHabit / daysSinceHabitCreation) * 100
                          : 0.0;

                      String habitTitle = allHabits[index].title;

                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                habitTitle,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Text(
                                  '${habitProgress.toInt()}%', // Safe conversion
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            )

          ],
        ),
      ),
    );
  }
}
