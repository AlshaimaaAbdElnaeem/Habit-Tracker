// navbar_project.dart
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class NavBarProject extends StatefulWidget {
  final Function(int) onTap;

  const NavBarProject({Key? key, required this.onTap}) : super(key: key);

  @override
  _NavBarProjectState createState() => _NavBarProjectState();
}

class _NavBarProjectState extends State<NavBarProject> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      color: Colors.blueAccent,
      buttonBackgroundColor: Colors.white,
      height: 60,
      items: <Widget>[
        Icon(Icons.home, size: 30, color: _pageIndex == 0 ? Colors.blue : Colors.white),
        Icon(Icons.bar_chart, size: 30, color: _pageIndex == 1 ? Colors.blue : Colors.white),
        Icon(Icons.person, size: 30, color: _pageIndex == 2 ? Colors.blue : Colors.white),
      ],
      onTap: (index) {
        setState(() {
          _pageIndex = index;
          widget.onTap(index); // Notify the parent widget of the selected index
        });
      },
    );
  }
}
