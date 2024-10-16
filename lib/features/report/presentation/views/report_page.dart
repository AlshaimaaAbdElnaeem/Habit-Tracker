import 'package:flutter/material.dart';

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
                            SizedBox(height: 5),
                            // Space between image and percentage
                            // Percentage text
                            Text(
                              '${(_progressValue * 100).toStringAsFixed(0)}%',
                              // Display percentage
                              style: TextStyle(
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
                                  Icon(Icons.check_circle,
                                      color: Colors.green, size: 16),
                                  // Reduce icon size
                                  SizedBox(width: 5),
                                  Text(
                                    task,
                                    style: TextStyle(
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
                                    style: TextStyle(
                                        fontSize:
                                        12), // Decrease task text size
                                  ),
                                  SizedBox(width: 5),
                                  Icon(Icons.radio_button_unchecked,
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
            SizedBox(height: 20),
            // Space between progress card and list
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                child: Text(
                  "History",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),

            // List of days with progress percentage
            Expanded(
              child: ListView.builder(
                itemCount: 7, // Example: 7 days
                itemBuilder: (context, index) {
                  // Example: simulate random progress for each day
                  int completedTasksForDay = (index + 1) %
                      5; // Example: completed tasks count for the day
                  int totalTasksForDay =
                      5; // Example: total tasks count for the day
                  double dayProgress =
                      (completedTasksForDay / totalTasksForDay) * 100;
                  String dayTitle = 'Day ${index + 1}'; // Example: Day number

                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Day title on the left
                          Text(
                            dayTitle,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          // Percentage icon on the right
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(
                              '${dayProgress.toInt()}%', // Display percentage
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
