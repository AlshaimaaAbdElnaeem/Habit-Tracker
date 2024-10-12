import 'package:flutter/material.dart';
import 'package:task_project/core/util/color.dart';

class AddNewPlans extends StatelessWidget {
  const AddNewPlans({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {},
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
