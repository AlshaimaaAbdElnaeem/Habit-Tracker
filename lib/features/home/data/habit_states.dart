import '../../../Habit_firebase.dart';

abstract class HabitStates {}

class HabitsInitial extends HabitStates {}

class HabitsLoading extends HabitStates {}

class HabitsLoaded extends HabitStates {
  final List<Habit> habits;
  HabitsLoaded(this.habits);
}

class HabitsUpdatedSuccessfully extends HabitStates {}
class HabitError extends HabitStates {
  final String error;

  HabitError(this.error);
}

class HabitsCompleted extends HabitStates {
  final List<Habit> habitsCompleted;
  HabitsCompleted(this.habitsCompleted);
}

class HabitsUncompleted extends HabitStates {
  final List<Habit> habitsUncompleted;
  HabitsUncompleted(this.habitsUncompleted);
}
