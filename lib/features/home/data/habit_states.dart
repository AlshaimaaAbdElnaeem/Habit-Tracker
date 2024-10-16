import '../../../Habit_firebase.dart';

abstract class HabitStates {}

class HabitsInitial extends HabitStates {}

class HabitsLoading extends HabitStates {}

class HabitsLoaded extends HabitStates {
  final List<Habit> habits;
  HabitsLoaded(this.habits);

}

class HabitError extends HabitStates {
  final String error;

  HabitError(this.error);
}
