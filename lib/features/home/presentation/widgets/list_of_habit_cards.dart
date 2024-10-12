import 'package:flutter/widgets.dart';
import 'package:task_project/features/home/presentation/widgets/habit_card.dart';

class ListOfHabitCards extends StatelessWidget {
  const ListOfHabitCards({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.52,
      child: ListView(
        children: const [
          HabitCard(),
          HabitCard(),
          HabitCard(),
          HabitCard(),
          HabitCard(),
          HabitCard(),
        ],
      ),
    );
  }
}
