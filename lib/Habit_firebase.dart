import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  String id;
  String title;
  bool isCompleted;
  String createdAt ;
  String practiceTime;

  Habit({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.practiceTime,
    required this.createdAt ,
  });

  // تحويل الكائن إلى خريطة لتخزينه في Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'createdAt': DateTime.now().toIso8601String(),
      'practiceTime': practiceTime,
    };
  }

  // إنشاء Habit من Firestore document
  factory Habit.fromMap(Map<String, dynamic> map, String id) {
    return Habit(
      id: id,
      title: map['title'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      createdAt: map["createdAt"]??"",
      practiceTime: map['practiceTime'] ?? '',
    );
  }

  // إضافة Habit جديد إلى Firestore
  Future<void> addHabit(String title, String practiceTime) async {
    CollectionReference habitsCollection =
    FirebaseFirestore.instance.collection('habits');

    String newId = habitsCollection.doc().id;

    Habit habit = Habit(
      id: id,
      title: title,
      createdAt: DateTime.now().toIso8601String(),
      practiceTime: practiceTime,
    );

    await habitsCollection.doc(newId).set(habit.toMap());
  }

  // جلب جميع الـ Habits
  Future<List<Habit>> getHabits() async {
    CollectionReference habitsCollection =
    FirebaseFirestore.instance.collection('habits');
    QuerySnapshot querySnapshot = await habitsCollection.get();

    return querySnapshot.docs.map((doc) {
      return Habit.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  // حذف Habit حسب id
  Future<void> deleteHabit(String id) async {
    await FirebaseFirestore.instance.collection('habits').doc(id).delete();
  }

  // تحديث Habit حسب id
  Future<void> updateHabit(String id, String newTitle, bool isCompleted) async {
    await FirebaseFirestore.instance.collection('habits').doc(id).update({
      'title': newTitle,
      'isCompleted': isCompleted,
    });
  }

  // تحديث وقت التدريب في Habit
  Future<void> updateHabitPracticeTime(String habitId, DateTime newPracticeTime) async {
    await FirebaseFirestore.instance.collection('habits').doc(habitId).update({
      'practiceTime': newPracticeTime.toIso8601String(),
    }).then((_) {
      print('Habit practice time updated successfully.');
    }).catchError((error) {
      print('Failed to update habit: $error');
    });
  }
}
