import 'package:flutter/material.dart';
import 'package:kira_version_one/screens/explore/audio_therapy.dart';
import 'package:kira_version_one/screens/explore/creative_corner.dart';
import 'package:kira_version_one/screens/explore/guided_meditation.dart';
import 'package:kira_version_one/screens/explore/mood_tracker.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<_ExploreItem> exploreItems = [
      _ExploreItem(
        title: 'Creative Corner',
        description: 'Draw, doodle or express freely.',
        icon: Icons.brush,
        color: Colors.pink.shade100,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreativeCorner()),
          );
        },
      ),
      _ExploreItem(
        title: 'Guided Meditation',
        description: 'Relax with breathing & mindfulness.',
        icon: Icons.self_improvement,
        color: Colors.blue.shade100,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GuidedMeditation()),
          );
        },
      ),
      // _ExploreItem(
      //   title: 'Audio Therapy',
      //   description: 'Listen to calming sounds based on your mood.',
      //   icon: Icons.headphones,
      //   color: Colors.green.shade100,
      //   onTap: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => AudioTherapy()),
      //     );
      //   },
      // ),
      _ExploreItem(
        title: 'Mood Tracker',
        description: 'Track your mood with fun activities.',
        icon: Icons.bar_chart,
        color: Colors.yellow.shade100,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MoodTrackerScreen()),
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
        backgroundColor: Colors.teal.shade100,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: ListView.builder(
          itemCount: exploreItems.length,
          itemBuilder: (context, index) {
            final item = exploreItems[index];
            return GestureDetector(
              onTap: item.onTap,
              child: Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                decoration: BoxDecoration(
                  color: item.color,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(item.icon, size: 45, color: Colors.black87),
                    SizedBox(width: 30),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            item.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ExploreItem {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  _ExploreItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}
