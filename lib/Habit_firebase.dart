import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  String userId;
  String title;
  bool isCompleted;
  Timestamp createdAt;
  String practiceTime;
  String habitId; // معرف العادة

  Habit({
    required this.userId,
    required this.title,
    this.isCompleted = false,
    required this.practiceTime,
    required this.createdAt,
  }) : habitId = ''; // تعيين habitId كقيمة فارغة بشكل افتراضي

  // تحويل الكائن إلى خريطة لتخزينه في Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'habitId': habitId, // إضافة habitId هنا
      'title': title,
      'isCompleted': isCompleted,
      'createdAt': createdAt, // تخزين Timestamp مباشرة
      'practiceTime': practiceTime,
    };
  }

  // إنشاء Habit من Firestore document
  factory Habit.fromMap(Map<String, dynamic> map, String id) {
    return Habit(
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      createdAt: map['createdAt'] ?? Timestamp.now(),
      practiceTime: map['practiceTime'] ?? '',
    )..habitId = id; // تعيين habitId من الوثيقة عند التحويل
  }

  // إضافة Habit جديد إلى Firestore
  Future<void> addHabit(String title, String practiceTime) async {
    CollectionReference habitsCollection =
    FirebaseFirestore.instance.collection('habits');

    String newId = habitsCollection.doc().id; // الحصول على ID جديد

    Habit habit = Habit(
      userId: userId,
      title: title,
      createdAt: Timestamp.now(), // استخدام Timestamp
      practiceTime: practiceTime,
    );

    habit.habitId = newId; // تعيين habitId للمعرف الجديد

    try {
      await habitsCollection.doc(newId).set(habit.toMap());
    } catch (e) {
      print('Error adding habit: $e');
    }
  }

  // استرجاع جميع العادات
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
}
