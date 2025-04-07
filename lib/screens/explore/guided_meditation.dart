// guided_meditation.dart
import 'package:flutter/material.dart';
import 'package:kira_version_one/widgets/guided_session_screen.dart';

class GuidedMeditation extends StatelessWidget {
  final List<MeditationItem> meditations = [
    MeditationItem(
      title: 'Breathe & Relax',
      description: 'A short breathwork session.',
      imagePath: 'assets/stickers/breathe.gif',
    ),
    MeditationItem(
      title: 'Body Scan',
      description: 'Calm your body & mind.',
      imagePath: 'assets/stickers/bodyscan.gif',
    ),
    MeditationItem(
      title: 'Mindful Moments',
      description: 'Focus and recharge.',
      imagePath: 'assets/stickers/mindful.gif',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guided Meditation'),
        backgroundColor: Colors.blueGrey[200],
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[100]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          itemCount: meditations.length,
          itemBuilder: (context, index) {
            final meditation = meditations[index];
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 3,
              color: Colors.white.withOpacity(0.9),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: Image.asset(
                  meditation.imagePath,
                  height: 60,
                  width: 60,
                ),
                title: Text(meditation.title,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text(meditation.description),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GuidedSessionScreen(
                        minutes: 1,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class MeditationItem {
  final String title;
  final String description;
  final String imagePath;

  MeditationItem({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}
