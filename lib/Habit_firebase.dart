import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  String userId;
  String title;
  bool isCompleted;
  Timestamp createdAt;
  String practiceTime;
  String habitId;
  String date;

  Habit({
    required this.userId,
    required this.title,
    this.isCompleted = false,
    required this.practiceTime,
    required this.createdAt,
    String? date,
    String? habitId,
  })  : date = date ?? DateTime.now().toLocal().toIso8601String().split('T')[0],
        habitId = habitId ?? ''; // تعديل هنا

  // تحويل الكائن إلى Map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'habitId': habitId, // تأكد من تعيين habitId بشكل صحيح هنا
      'title': title,
      'isCompleted': isCompleted,
      'createdAt': createdAt,
      'practiceTime': practiceTime,
      'date': date,
    };
  }

  // إنشاء كائن Habit من Map
  factory Habit.fromMap(Map<String, dynamic> map, String id) {
    return Habit(
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      createdAt: map['createdAt'] ?? Timestamp.now(),
      practiceTime: map['practiceTime'] ?? '',
      date: map['date'],
      habitId: id, // تعيين id في الحقل habitId هنا
    );
  }

  // إضافة عادة جديدة
  Future<void> addHabit(String title, String practiceTime) async {
    CollectionReference habitsCollection =
    FirebaseFirestore.instance.collection('habits');

    String newId = habitsCollection.doc().id; // توليد معرّف جديد

    Habit habit = Habit(
      userId: userId,
      title: title,
      createdAt: Timestamp.now(),
      date: date,
      practiceTime: practiceTime,
      habitId: newId, // تعيين habitId بشكل صحيح
    );

    try {
      await habitsCollection.doc(newId).set(habit.toMap());
      print('Habit added: ${habit.toMap()}');
    } catch (e) {
      print('Error adding habit: $e');
    }
  }

  // حذف عادة
  Future<void> deleteHabit(String id) async {
    try {
      await FirebaseFirestore.instance.collection('habits').doc(id).delete();
      print('Habit with id $id deleted successfully.');
    } catch (e) {
      print('Error deleting habit: $e');
    }
  }

  // تحديث عادة حسب id
  Future<void> updateHabit(String id, String newTitle, bool isCompleted) async {
    try {
      await FirebaseFirestore.instance.collection('habits').doc(id).update({
        'title': newTitle,
        'isCompleted': isCompleted,
      });
      print('Habit updated successfully.');
    } catch (e) {
      print('Error updating habit: $e');
    }
  }
}
