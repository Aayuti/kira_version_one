import 'package:flutter/material.dart';
import 'nav/home_screen.dart';
import 'nav/activities_screen.dart';
import 'nav/explore_screen.dart';
import './profile/ProfileScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    ActivitiesScreen(),
    ExploreScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Show selected page
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.blue, // Default black background
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)), // Rounded edges
          boxShadow: [
            BoxShadow(
              color: Colors.black12, // Soft shadow for effect
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)), // More rounded edges
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent, // Transparent to apply container color
            selectedItemColor: Colors.blue, // Highlight color when clicked
            unselectedItemColor: Colors.grey[400], // Unselected icons in grey (visible on black)
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed, // Keeps labels visible
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Activities'),
              BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
