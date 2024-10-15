import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  String id;
  String title;
  bool isCompleted;
  DateTime createdAt;
  DateTime practiceTime;

  Habit({required this.id, required this.title, this.isCompleted = false, required this.createdAt, required this.practiceTime,});

  //Converting habit into a storable data in Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'practiceTime': practiceTime.toIso8601String(),
    };
  }

  //Creating the habit object from Firestore document
  factory Habit.fromMap(Map<String, dynamic> map, String id) {
    return Habit(
      id: id,
      title: map['title'],
      isCompleted: map['isCompleted'],
      createdAt: DateTime.parse(map['createdAt']),
      practiceTime: DateTime.parse(map['practiceTime']),
    );
  }



  void addHabit(String title) async {
    CollectionReference habitsCollection = FirebaseFirestore.instance.collection('habits');

    Habit habit = Habit(
      id: habitsCollection.doc().id, // creating an automatic id
      title: title,
      createdAt: DateTime.now(),
      practiceTime: practiceTime,
    );

    await habitsCollection.doc(habit.id).set(habit.toMap());
  }

  Future<List<Habit>> getHabits() async {
    CollectionReference habitsCollection = FirebaseFirestore.instance.collection('habits');
    QuerySnapshot querySnapshot = await habitsCollection.get();

    return querySnapshot.docs.map((doc) {
      return Habit.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  void deleteHabit(String id) async {
    await FirebaseFirestore.instance.collection('habits').doc(id).delete();
  }

  void updateHabit(String id, String newTitle, bool isCompleted) async {
    await FirebaseFirestore.instance.collection('habits').doc(id).update({
      'title': newTitle,
      'isCompleted': isCompleted,
    });
  }

  void updateHabitPracticeTime(String habitId, DateTime newPracticeTime) {
    FirebaseFirestore.instance.collection('habits').doc(habitId).update({
      'practiceTime': newPracticeTime.toIso8601String(),
    }).then((_) {
      print('Habit practice time updated successfully.');
    }).catchError((error) {
      print('Failed to update habit: $error');
    });
  }


}
