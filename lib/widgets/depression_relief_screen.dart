import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DepressionReliefScreen extends StatefulWidget {
  @override
  _DepressionReliefScreenState createState() => _DepressionReliefScreenState();
}

class _DepressionReliefScreenState extends State<DepressionReliefScreen> {
  final TextEditingController _gratitudeController = TextEditingController();
  List<String> _gratitudeList = [];

  final List<String> _affirmations = [
    "🌈 I am worthy of love and happiness.",
    "🚶‍♂️ Small steps are still progress.",
    "💪 I am stronger than I think.",
    "☀️ Every day is a new beginning.",
  ];

  int _currentAffirmation = 0;

  void _addGratitude() {
    if (_gratitudeController.text.trim().isNotEmpty) {
      setState(() {
        _gratitudeList.add(_gratitudeController.text.trim());
        _gratitudeController.clear();
      });
    }
  }

  void _nextAffirmation() {
    setState(() {
      _currentAffirmation = (_currentAffirmation + 1) % _affirmations.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF4F7),
      appBar: AppBar(
        backgroundColor: Colors.purple.shade100,
        title: Text("Lift Your Spirits", style: GoogleFonts.quicksand()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Gratitude Journal Section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Gratitude Journal",
                        style: GoogleFonts.quicksand(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    TextField(
                      controller: _gratitudeController,
                      decoration: InputDecoration(
                        hintText: "What made you feel better today?",
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _addGratitude,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade300,
                      ),
                      child: Text(
                        "Add Entry",
                        style: GoogleFonts.quicksand(
                            color: Colors.white), // Changed here
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Gratitude Entries
              if (_gratitudeList.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Your Entries:",
                        style:
                            GoogleFonts.quicksand(fontWeight: FontWeight.w600)),
                    ..._gratitudeList
                        .map((entry) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 4,
                                        color: Colors.grey.shade200)
                                  ],
                                ),
                                padding: EdgeInsets.all(12),
                                child:
                                    Text(entry, style: GoogleFonts.quicksand()),
                              ),
                            ))
                        .toList(),
                  ],
                ),

              SizedBox(height: 30),

              // Affirmations
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      _affirmations[_currentAffirmation],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.deepPurple.shade700,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              Image.asset(
                'assets/stickers/relaxing.gif',
                height: 160,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
