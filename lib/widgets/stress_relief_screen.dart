import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StressReliefScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent[100],
        title: Text(
          'Manage Your Stress',
          style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "“Almost everything will work again if you unplug it for a few minutes… including you.”",
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Image.asset('assets/stickers/stress_relief.gif', height: 160),
            ),
            SizedBox(height: 30),
            Text(
              "Try This: 4-7-8 Breathing Technique",
              style: GoogleFonts.quicksand(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal[700],
              ),
            ),
            SizedBox(height: 10),
            _buildStep("1. Breathe in through your nose for 4 seconds."),
            _buildStep("2. Hold your breath for 7 seconds."),
            _buildStep("3. Exhale slowly through your mouth for 8 seconds."),
            _buildStep("4. Repeat this cycle 4 times."),
            SizedBox(height: 25),
            Text(
              "Quick Tips to Ease Stress",
              style: GoogleFonts.quicksand(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.pink[800],
              ),
            ),
            SizedBox(height: 10),
            _buildTip("🌿 Step outside for 5 minutes and breathe."),
            _buildTip("📓 Write down your thoughts and let go."),
            _buildTip("🎧 Listen to soothing music."),
            _buildTip("💤 Take a short nap or lie down."),
            _buildTip("📵 Disconnect from your phone for 10 minutes."),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.teal[400], size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.quicksand(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Text(
        tip,
        style: GoogleFonts.quicksand(fontSize: 14, color: Colors.grey[800]),
      ),
    );
  }
}
