import 'package:flutter/material.dart';
import 'package:kira_version_one/chatbot/chatbot.dart';
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
    ChatbotScreen(),
    ExploreScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Show selected page
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 186, 228, 231), // Default black background
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)), // Rounded edges
         
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)), // More rounded edges
          child: BottomNavigationBar(
            backgroundColor: const Color.fromARGB(255, 160, 228, 238), // Transparent to apply container color
            selectedItemColor: Colors.blue, // Highlight color when clicked
            unselectedItemColor: const Color.fromARGB(255, 66, 81, 86), // Unselected icons in grey (visible on black)
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed, // Keeps labels visible
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/chatbot.png', // same as used in your FAB
                  height: 24,
                  width: 24,
                ),
                label: 'Kira AI',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
