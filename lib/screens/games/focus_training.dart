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
  String _emoji = "😴"; // default emoji

  void _startGame() {
    setState(() {
      _canTap = false;
      _color = Colors.red;
      _emoji = "😴";
      _reactionTime = 0;
    });

    int randomTime = Random().nextInt(3) + 2;

    Future.delayed(Duration(seconds: randomTime), () {
      setState(() {
        _color = Colors.green;
        _canTap = true;
        _startTime = DateTime.now();
        _emoji = "🚦";
      });
    });
  }

  void _tapReaction() {
    if (_canTap) {
      setState(() {
        _reactionTime = DateTime.now().difference(_startTime).inMilliseconds;
        _emoji = "🎉";
        _canTap = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("⚡ Your reaction time: $_reactionTime ms"),
        backgroundColor: Colors.purple.shade200,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F7FD), // soft pastel background
      appBar: AppBar(
        title: Text("Focus Training Game"),
        backgroundColor: Colors.purple.shade200,
        elevation: 4,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tap when the screen turns GREEN!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade400,
              ),
            ),
            SizedBox(height: 20),
            Text(
              _emoji,
              style: TextStyle(fontSize: 50),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _tapReaction,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  gradient: _color == Colors.red
                      ? LinearGradient(
                          colors: [Colors.red.shade200, Colors.red.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : LinearGradient(
                          colors: [Colors.green.shade200, Colors.green.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(4, 4),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _startGame,
              icon: Icon(Icons.play_arrow, color: Colors.white),
              label: Text(
                "Start",
                style: TextStyle(
                  color: Colors.white, // changed text color
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade300,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
            SizedBox(height: 20),
            if (_reactionTime > 0)
              Text(
                "⏱️ $_reactionTime ms",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
