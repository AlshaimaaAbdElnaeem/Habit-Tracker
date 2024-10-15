import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  String id;
  String title;
  bool isCompleted;
  DateTime createdAt;

  Habit({required this.id, required this.title, this.isCompleted = false, required this.createdAt});

  //Converting habit into a storable data in Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  //Creating the habit object from Firestore document
  factory Habit.fromMap(Map<String, dynamic> map, String id) {
    return Habit(
      id: id,
      title: map['title'],
      isCompleted: map['isCompleted'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }



  void addHabit(String title) async {
    CollectionReference habitsCollection = FirebaseFirestore.instance.collection('habits');

    Habit habit = Habit(
      id: habitsCollection.doc().id, // creating an automatic id
      title: title,
      createdAt: DateTime.now(),
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

}
