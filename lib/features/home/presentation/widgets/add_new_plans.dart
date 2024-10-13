import 'package:flutter/material.dart';
import 'package:task_project/core/util/color.dart';
import 'package:task_project/features/home/presentation/views/add_new_habit.dart';

class AddNewHabit extends StatelessWidget {
  const AddNewHabit({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>const CreateCustomHabit()),
              );
            },
            icon: Icon(
              Icons.add_circle,
              color: AppColors.primaryColor,
            )),
        const Text(
          "Add new habit",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
