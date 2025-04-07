import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnxietyReliefScreen extends StatefulWidget {
  @override
  _AnxietyReliefScreenState createState() => _AnxietyReliefScreenState();
}

class _AnxietyReliefScreenState extends State<AnxietyReliefScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final TextEditingController _journalController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 80, end: 160).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _journalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDAF3E4), // Soft green tone
      appBar: AppBar(
        title: Text(
          'Anxiety Relief',
          style: GoogleFonts.quicksand(
            color: Colors.teal[900],
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.teal[900]),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
            children: [
              Text(
                'Breathe with me',
                style: GoogleFonts.quicksand(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.teal[800],
                ),
              ),
              SizedBox(height: 20),
              AnimatedBuilder(
                animation: _controller,
                builder: (_, child) {
                  return Container(
                    width: _animation.value,
                    height: _animation.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.teal[200],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.withOpacity(0.4),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _controller.value < 0.5 ? 'Inhale' : 'Exhale',
                        style: GoogleFonts.quicksand(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 40),
              Text(
                'Anxiety Journal',
                style: GoogleFonts.quicksand(
                  fontSize: 18,
                  color: Colors.teal[800],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/textures/book_page_bg.jpg'), // Add this texture
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.shade100,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    controller: _journalController,
                    maxLines: null,
                    expands: true,
                    style: GoogleFonts.dancingScript(
                      fontSize: 16,
                      color: Colors.brown[800],
                      height: 1.5,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Dear Journal...",
                      hintStyle: GoogleFonts.dancingScript(
                        fontSize: 16,
                        color: Colors.brown[300],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  // Save logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text("Journal saved"),
                        backgroundColor: Colors.teal),
                  );
                },
                icon: Icon(Icons.save_alt),
                label: Text("Save Entry"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[300],
                  foregroundColor: Colors.white,
                  shadowColor: Colors.brown[100],
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
