import 'package:flutter/material.dart';
import 'dart:math';

class PositiveAffirmationsGame extends StatefulWidget {
  @override
  _PositiveAffirmationsGameState createState() => _PositiveAffirmationsGameState();
}

class _PositiveAffirmationsGameState extends State<PositiveAffirmationsGame> {
  final List<String> _affirmations = [
    "You are capable of amazing things! 🌟",
    "You deserve happiness and peace. 💙",
    "Every challenge is an opportunity to grow. 🌱",
    "You are stronger than you think! 💪",
    "Your feelings are valid, and you matter. ❤️",
    "Keep going, you're doing great! 🚀",
  ];

  String _currentAffirmation = "Tap below for a positive boost!";

  void _generateAffirmation() {
    setState(() {
      _currentAffirmation = _affirmations[Random().nextInt(_affirmations.length)];
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("New Affirmation Added! 💖"),
      duration: Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Positive Affirmations")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                _currentAffirmation,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
            ),
            SizedBox(height: 20),
            Icon(Icons.favorite, size: 100, color: Colors.pink),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateAffirmation,
              child: Text("Get a New Affirmation"),
            ),
          ],
        ),
      ),
    );
  }
}
