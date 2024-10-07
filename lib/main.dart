import 'package:flutter/material.dart';
import 'features/home/presentation/views/home_page.dart';
import 'features/report/presentation/views/report_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

