import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/features/home/data/habit_states.dart';
import '../../../Habit_firebase.dart';

class HabitCubit extends Cubit<HabitStates> {
  HabitCubit() : super(HabitsInitial());

  final CollectionReference habitsCollection =
  FirebaseFirestore.instance.collection('habits');

  // جلب العادات حسب ID ثم ترتيبها برمجيًا حسب `createAt`
  Future<void> fetchHabitsById(String id) async {
    try {
      emit(HabitsLoading());
      QuerySnapshot querySnapshot = await habitsCollection
          .where('userId', isEqualTo: id)
          .get();

      List<Habit> habits = querySnapshot.docs.map((doc) {
        return Habit.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      habits.sort((a, b) {
        return b.createdAt.compareTo(a.createdAt);
      });

      emit(HabitsLoaded(habits));
    } catch (e) {
      print(e.toString());
      emit(HabitError(e.toString()));
    }
  }

  // تحديث حالة العادة
  Future<void> updateHabit(String id, bool isCompleted) async {
    try {
      // استعلام لتحديث العادة بناءً على habitId
      QuerySnapshot querySnapshot = await habitsCollection
          .where('habitId', isEqualTo: id)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // إذا تم العثور على العادة، قم بالتحديث
        await habitsCollection.doc(querySnapshot.docs.first.id).update({
          'isCompleted': isCompleted,
        });
        emit(HabitsUpdatedSuccessfully());
        print('Habit updated successfully');
      } else {
        print('No habit found with the specified habitId');
        emit(HabitError('No habit found with the specified habitId'));
      }
    } catch (e) {
      print(e.toString());
      emit(HabitError(e.toString()));
    }

  }

  @override
  void onChange(Change<HabitStates> change) {
    print(change);
    super.onChange(change);
  }
}
