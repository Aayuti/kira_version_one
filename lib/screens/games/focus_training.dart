import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class FocusTrainingGame extends StatefulWidget {
  @override
  _FocusTrainingGameState createState() => _FocusTrainingGameState();
}

class _FocusTrainingGameState extends State<FocusTrainingGame> {
  Color _color = Colors.red;
  bool _canTap = false;
  int _reactionTime = 0;
  late DateTime _startTime;

  void _startGame() {
    setState(() {
      _canTap = false;
      _color = Colors.red;
    });

    int randomTime = Random().nextInt(3) + 2; // 2 to 5 seconds

    Future.delayed(Duration(seconds: randomTime), () {
      setState(() {
        _color = Colors.green;
        _canTap = true;
        _startTime = DateTime.now();
      });
    });
  }

  void _tapReaction() {
    if (_canTap) {
      setState(() {
        _reactionTime = DateTime.now().difference(_startTime).inMilliseconds;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Your reaction time: $_reactionTime ms"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Focus Training Game")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tap when the screen turns GREEN!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _tapReaction,
              child: Container(
                width: 200,
                height: 200,
                color: _color,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startGame,
              child: Text("Start"),
            ),
          ],
        ),
      ),
    );
  }
}
