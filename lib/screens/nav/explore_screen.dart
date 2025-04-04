import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50], // Light yellow background
      body: Center(child: Text("🔍 Explore Screen", style: TextStyle(fontSize: 24))),
    );
  }
}
