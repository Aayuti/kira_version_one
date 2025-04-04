import 'package:flutter/material.dart';

class BreathingExerciseGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Breathing Exercise")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Follow the breathing pattern",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Icon(Icons.air, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Inhale... Exhale... Relax"),
                  duration: Duration(seconds: 3),
                ));
              },
              child: Text("Start Breathing"),
            ),
          ],
        ),
      ),
    );
  }
}
