import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GuidedSessionScreen extends StatefulWidget {
  final int minutes;

  const GuidedSessionScreen({Key? key, required this.minutes}) : super(key: key);

  @override
  State<GuidedSessionScreen> createState() => _GuidedSessionScreenState();
}

class _GuidedSessionScreenState extends State<GuidedSessionScreen> {
  Duration remainingTime = Duration();
  Timer? timer;
  bool isRunning = false;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    remainingTime = Duration(minutes: widget.minutes);
  }

  @override
  void dispose() {
    timer?.cancel();
    audioPlayer.stop();
    super.dispose();
  }

  void startSession() async {
    if (isRunning) return;

    setState(() {
      isRunning = true;
    });

    // Start audio playback (make sure your audio asset is added in pubspec.yaml)
    await audioPlayer.play(AssetSource('audio/meditation_music.mp3')); // your audio path

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (remainingTime.inSeconds > 0) {
          remainingTime -= Duration(seconds: 1);
        } else {
          t.cancel();
          audioPlayer.stop();
          isRunning = false;
        }
      });
    });
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds % 60)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE1F5FE), // pastel blue
      appBar: AppBar(
        title: Text("Guided Session"),
        backgroundColor: Color(0xFFB3E5FC),
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Relax & Breathe",
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                ),
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Color(0xFF81D4FA), width: 4),
                ),
                child: Text(
                  formatTime(remainingTime),
                  style: GoogleFonts.poppins(
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey[900],
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: startSession,
                icon: Icon(Icons.play_arrow),
                label: Text(isRunning ? "Session Running..." : "Start Session"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF81D4FA),
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  textStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
