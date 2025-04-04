import 'package:flutter/material.dart';

class MoodTrackerGame extends StatefulWidget {
  @override
  _MoodTrackerGameState createState() => _MoodTrackerGameState();
}

class _MoodTrackerGameState extends State<MoodTrackerGame> {
  String _selectedMood = "😊"; // Default mood

  final List<String> _moods = ["😊", "😐", "😢", "😡", "😴"];

  void _selectMood(String mood) {
    setState(() {
      _selectedMood = mood;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Mood recorded: $mood"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mood Tracker")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "How are you feeling today?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(_selectedMood, style: TextStyle(fontSize: 60)),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: _moods.map((mood) {
                return GestureDetector(
                  onTap: () => _selectMood(mood),
                  child: Text(mood, style: TextStyle(fontSize: 40)),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
