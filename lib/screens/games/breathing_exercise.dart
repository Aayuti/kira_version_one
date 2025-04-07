import 'package:flutter/material.dart';
import 'dart:async';

class BreathingExerciseGame extends StatefulWidget {
  @override
  _BreathingExerciseGameState createState() => _BreathingExerciseGameState();
}

class _BreathingExerciseGameState extends State<BreathingExerciseGame>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String _instruction = "Ready?";
  Timer? _instructionTimer;

  final List<String> _cycle = ["Inhale 🌸", "Hold ✨", "Exhale 💨"];
  int _cycleIndex = 0;

  void _startBreathingCycle() {
    _instructionTimer?.cancel();
    _cycleIndex = 0;
    _instruction = _cycle[_cycleIndex];

    _controller.repeat(reverse: true);

    _instructionTimer = Timer.periodic(Duration(seconds: 4), (timer) {
      setState(() {
        _cycleIndex = (_cycleIndex + 1) % _cycle.length;
        _instruction = _cycle[_cycleIndex];
      });
    });
  }

  void _stopCycle() {
    _controller.stop();
    _instructionTimer?.cancel();
    setState(() {
      _instruction = "Ready?";
    });
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _animation = Tween<double>(begin: 100, end: 200).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    _instructionTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF6FF), // light blue pastel
      appBar: AppBar(
        title: Text("Breathing Exercise"),
        backgroundColor: Colors.lightBlue.shade200,
        elevation: 2,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Follow the breathing rhythm",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade700,
              ),
            ),
            SizedBox(height: 40),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  width: _animation.value,
                  height: _animation.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.lightBlue.shade100.withOpacity(0.7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade100,
                        blurRadius: 10,
                        spreadRadius: 5,
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      _instruction,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _startBreathingCycle,
              icon: Icon(Icons.play_arrow),
              label: Text(
                "Start Breathing",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade300,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: _stopCycle,
              child: Text(
                "Stop",
                style: TextStyle(color: Colors.grey.shade700),
              ),
            )
          ],
        ),
      ),
    );
  }
}
