import 'package:flutter/material.dart';
import 'package:kira_version_one/screens/games/positive_affirmations.dart';
import '../../widgets/mental_health_topic_screen.dart';
import '../games/breathing_exercise.dart';
import '../games/memory_game.dart';
import '../games/focus_training.dart';
import '../games/mood_tracker.dart';
import '../../chatbot/chatbot.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _mentalHealthTopics = [
    {'title': 'Stress', 'color': Color(0xFFFFC1CC), 'icon': Icons.self_improvement, 'quote': "Take a deep breath. You got this!"},
    {'title': 'Anxiety', 'color': Color(0xFFB3E5FC), 'icon': Icons.sentiment_dissatisfied, 'quote': "Your mind is stronger than your anxiety."},
    {'title': 'Depression', 'color': Color(0xFFB2DFDB), 'icon': Icons.mood_bad, 'quote': "Even the darkest night will pass, and the sun will rise."},
    {'title': 'OCD', 'color': Color(0xFFD1C4E9), 'icon': Icons.repeat, 'quote': "You are not your intrusive thoughts."},
    {'title': 'PTSD', 'color': Color(0xFFFFE0B2), 'icon': Icons.flash_on, 'quote': "Healing takes time, and that's okay."},
  ];

  final List<Map<String, dynamic>> _gamesList = [
    {'title': 'Breathe slow', 'color': Color(0xFFA5D6A7), 'icon': Icons.air, 'page': BreathingExerciseGame()},
    {'title': 'Memory game', 'color': Color(0xFFFFCC80), 'icon': Icons.memory, 'page': MemoryBoostGame()},
    {'title': 'Are you focused?', 'color': Color(0xFF81D4FA), 'icon': Icons.remove_red_eye, 'page': FocusTrainingGame()},
    {'title': 'Track your mood', 'color': Color(0xFFCE93D8), 'icon': Icons.emoji_emotions, 'page': MoodTrackerGame()},
    {'title': 'Positive Affirmations', 'color': Color(0xFFB3E5FC), 'icon': Icons.sentiment_satisfied, 'page': PositiveAffirmationsGame()},
  ];

  final List<String> _positiveQuotes = [
    "Your mental health is a priority. Take care of it! 💙",
    "One small step each day leads to great healing. 🌱",
    "Breathe. You are stronger than you think. 🌸",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 243, 249),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _positiveQuotes[_currentIndex % _positiveQuotes.length],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  Image.asset('assets/stickers/sticker1.gif', height: 80),
                ],
              ),
            ),
            _buildHorizontalList("Mental Health Topics", _mentalHealthTopics, (index) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MentalHealthTopicScreen(
                    title: _mentalHealthTopics[index]['title'],
                    quote: _mentalHealthTopics[index]['quote'], backgroundColor: Colors.pinkAccent, topic: 'Add',
                  ),
                ),
              );
            }),
            SizedBox(height: 20),
            _buildHorizontalList("Mindful Games", _gamesList, (index) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _gamesList[index]['page']),
              );
            }),
            SizedBox(height: 30),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Professional Help",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 202, 205, 207),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                leading: Icon(Icons.person, color: Colors.blueGrey),
                                title: Text(
                                  "Professional ${index + 1}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text("+91 98765${index}4321"),
                                trailing: IconButton(
                                  icon: Icon(Icons.call, color: Colors.green),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatbotScreen()),
          );
        },
        backgroundColor: Colors.green[400],
        child: Icon(Icons.chat, color: Colors.white),
      ),
    );
  }

  Widget _buildHorizontalList(String title, List<Map<String, dynamic>> list, Function(int) onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 120,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => onTap(index),
                child: Container(
                  width: 120,
                  margin: EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: list[index]['color'],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2)],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(list[index]['icon'], size: 40, color: Colors.black),
                      SizedBox(height: 8),
                      Text(
                        list[index]['title'],
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
