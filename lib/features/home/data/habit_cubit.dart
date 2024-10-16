import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/features/home/data/habit_states.dart';

import '../../../Habit_firebase.dart';


class HabitCubit extends Cubit<HabitStates> {
  HabitCubit() : super(HabitsInitial());

  final CollectionReference habitsCollection =
  FirebaseFirestore.instance.collection('habits');

  Future<void> fetchHabitsById(String id ) async {
    try {
      emit(HabitsLoading());
      QuerySnapshot querySnapshot = await habitsCollection
          .where('id', isEqualTo: id)
          .get();
      List<Habit> habits = querySnapshot.docs.map((doc) {
        return Habit.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();


        emit(HabitsLoaded(habits));
    } catch (e) {
      emit(HabitError(e.toString()));
    }
  }
  @override
  void onChange(Change<HabitStates> change) {
    // TODO: implement onChange
    print(change);
    super.onChange(change);
  }
}
