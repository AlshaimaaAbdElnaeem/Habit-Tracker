import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  String userId;
  String title;
  bool isCompleted;
  Timestamp createdAt;
  String practiceTime;
  String habitId; // Habit ID

  Habit({
    required this.userId,
    required this.title,
    this.isCompleted = false,
    required this.practiceTime,
    required this.createdAt,
  }) : habitId = ''; // Set habitId to an empty value by default

  // Convert the object to a map for storing it in Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'habitId': habitId, // Add habitId here
      'title': title,
      'isCompleted': isCompleted,
      'createdAt': createdAt, // Store Timestamp directly
      'practiceTime': practiceTime,
    };
  }

  // Create Habit from Firestore document
  factory Habit.fromMap(Map<String, dynamic> map, String id) {
    return Habit(
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      createdAt: map['createdAt'] ?? Timestamp.now(),
      practiceTime: map['practiceTime'] ?? '',
    )..habitId = id; // Set habitId from the document during conversion
  }

  // Add a new Habit to Firestore
  Future<void> addHabit(String title, String practiceTime) async {
    CollectionReference habitsCollection =
    FirebaseFirestore.instance.collection('habits');

    String newId = habitsCollection.doc().id; // Get a new ID

    Habit habit = Habit(
      userId: userId,
      title: title,
      createdAt: Timestamp.now(), // Use Timestamp
      practiceTime: practiceTime,
    );

    habit.habitId = newId; // Set habitId for the new ID

    try {
      await habitsCollection.doc(newId).set(habit.toMap());
    } catch (e) {
      print('Error adding habit: $e');
    }
  }

  // Retrieve all habits
  Future<List<Habit>> getHabits() async {
    CollectionReference habitsCollection =
    FirebaseFirestore.instance.collection('habits');
    QuerySnapshot querySnapshot = await habitsCollection.get();

    return querySnapshot.docs.map((doc) {
      return Habit.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  // Delete Habit by id
  Future<void> deleteHabit(String id) async {
    await FirebaseFirestore.instance.collection('habits').doc(id).delete();
  }

  // Update Habit by id
  Future<void> updateHabit(String id, String newTitle, bool isCompleted) async {
    await FirebaseFirestore.instance.collection('habits').doc(id).update({
      'title': newTitle,
      'isCompleted': isCompleted,
    });
  }
}
