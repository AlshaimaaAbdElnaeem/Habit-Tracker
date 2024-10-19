import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/features/home/data/habit_states.dart';
import '../../../Habit_firebase.dart';

class HabitCubit extends Cubit<HabitStates> {
  HabitCubit() : super(HabitsInitial());

  final CollectionReference habitsCollection =
  FirebaseFirestore.instance.collection('habits');

  Future<void> fetchHabitsById(String id, String dateString) async {
    try {
      emit(HabitsLoading());
      QuerySnapshot querySnapshot = await habitsCollection
          .where('userId', isEqualTo: id)
          .where('date', isEqualTo: dateString) // استخدم التاريخ المحدد
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



  // Fetch only completed habits by user ID
  Future<void> fetchCompletedHabitsById(String id) async {
    try {
      emit(HabitsLoading());
      QuerySnapshot querySnapshot = await habitsCollection
          .where('userId', isEqualTo: id)
          .where('isCompleted', isEqualTo: true)
          .get();

      List<Habit> habits = querySnapshot.docs.map((doc) {
        return Habit.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      habits.sort((a, b) {
        return b.createdAt.compareTo(a.createdAt);
      });

      emit(HabitsCompleted(habits));
    } catch (e) {
      print(e.toString());
      emit(HabitError(e.toString()));
    }
  }

  // Fetch only uncompleted habits by user ID
  Future<void> fetchUncompletedHabitsById(String id) async {
    try {
      emit(HabitsLoading());
      QuerySnapshot querySnapshot = await habitsCollection
          .where('userId', isEqualTo: id)
          .where('isCompleted', isEqualTo: false)
          .get();

      List<Habit> habits = querySnapshot.docs.map((doc) {
        return Habit.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      habits.sort((a, b) {
        return b.createdAt.compareTo(a.createdAt);
      });

      emit(HabitsUncompleted(habits));
    } catch (e) {
      print(e.toString());
      emit(HabitError(e.toString()));
    }
  }


  Future<void> updateHabit(String id, bool isCompleted) async {
    try {
      QuerySnapshot querySnapshot = await habitsCollection
          .where('habitId', isEqualTo: id)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // If the habit is found, update it
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

  Future<void> resetHabitsIfNewDay(String userId) async {
    CollectionReference habitsCollection = FirebaseFirestore.instance.collection('habits');
    DateTime today = DateTime.now().toLocal();
    String todayString = today.toIso8601String().split('T')[0];

    // التحقق من وجود عادات لهذا اليوم
    QuerySnapshot previousHabitsSnapshot = await habitsCollection
        .where('userId', isEqualTo: userId)
        .where('date', isEqualTo: todayString)
        .get();

    if (previousHabitsSnapshot.docs.isEmpty) {
      // جلب العادات من اليوم السابق
      QuerySnapshot previousDateSnapshot = await habitsCollection
          .where('userId', isEqualTo: userId)
          .where('date', isEqualTo: today.subtract(Duration(days: 1)).toIso8601String().split('T')[0])
          .get();

      // نسخ جميع العادات
      for (var doc in previousDateSnapshot.docs) {
        Habit habit = Habit.fromMap(doc.data() as Map<String, dynamic>, doc.id);

        // توليد معرف جديد لكل عادة
        String newHabitId = habitsCollection.doc().id;

        Habit newHabit = Habit(
          userId: habit.userId,
          title: habit.title,
          isCompleted: false,  // إعادة تعيين الحالة إلى غير مكتملة
          practiceTime: habit.practiceTime,
          createdAt: Timestamp.now(),
          date: todayString,
          habitId: newHabitId,  // تعيين المعرف هنا بشكل صحيح
        );

        // إنشاء الوثيقة الجديدة باستخدام المعرف المخصص
        await habitsCollection.doc(newHabitId).set(newHabit.toMap());
      }
    }
  }



  Future<void> deleteHabit(String id) async {
    await FirebaseFirestore.instance.collection('habits').doc(id).delete();
  }

  @override
  void onChange(Change<HabitStates> change) {
    print(change);
    super.onChange(change);
  }
}
