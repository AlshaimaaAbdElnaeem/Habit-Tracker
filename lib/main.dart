import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/features/home/presentation/views/home_page.dart'; // Import HomePage // Import SignInPage
import 'package:task_project/features/report/presentation/views/report_page.dart';
import 'package:task_project/features/navbar/presentation/widget/navbar_project.dart';
import 'package:task_project/firebase_options.dart';

import 'features/auth/data/auth_cubit/auth_cubit.dart';
import 'features/auth/data/auth_cubit/auth_states.dart';
import 'features/splash/presentation/widgets/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(providers: [
      BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(InitialState()),
      ),
    ], child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), // Set SignInPage as the home page
    ),);



  }
}

// Optionally, keep HomeScreen for navigation if needed
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    ReportPage(),
    const Center(child: Text('Profile', style: TextStyle(fontSize: 24))),
  ];

  void _onNavBarTap(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pageIndex],
      bottomNavigationBar: NavBarProject(onTap: _onNavBarTap),
    );
  }
}
