import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Habit_firebase.dart';

Stream<List<Habit>> habitStream() {
  return FirebaseFirestore.instance.collection('habits').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => Habit.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
  });


}



