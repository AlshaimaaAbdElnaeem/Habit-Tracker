// main.dart
import 'package:flutter/material.dart';
import 'package:task_project/features/home/presentation/views/home_page.dart';
import 'package:task_project/features/report/presentation/views/report_page.dart';
import 'package:task_project/features/splash/presentation/widgets/navbar_project.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(), // نستخدم HomeScreen التي تحتوي على NavBarProject
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;

  // قائمة الصفحات التي سيتم التنقل بينها
  final List<Widget> _pages = [
    HomePage(), // استدعاء HomePage من import
    ReportPage(), // استدعاء ReportPage من import
    Center(child: Text('Profile', style: TextStyle(fontSize: 24))), // صفحة Profile كمثال
  ];

  // عند الضغط على أيقونة في الـ NavBar
  void _onNavBarTap(int index) {
    setState(() {
      _pageIndex = index; // يتم تغيير الصفحة حسب الأيقونة المختارة
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pageIndex], // عرض الصفحة الحالية حسب اختيار المستخدم
      bottomNavigationBar: NavBarProject(onTap: _onNavBarTap), // استدعاء الـ NavBarProject
    );
  }
}
