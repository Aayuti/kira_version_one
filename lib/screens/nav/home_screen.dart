import 'package:flutter/material.dart';
import 'package:kira_version_one/screens/games/positive_affirmations.dart';
import 'package:kira_version_one/widgets/anxiety_relief_screen.dart';
import 'package:kira_version_one/widgets/depression_relief_screen.dart';
import 'package:kira_version_one/widgets/medical_contacts_list.dart';
import 'package:kira_version_one/widgets/ocd_info_screen.dart';
import 'package:kira_version_one/widgets/ptsd_screen.dart';
import 'package:kira_version_one/widgets/stress_relief_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../widgets/mental_health_topic_screen.dart';
import '../games/breathing_exercise.dart';
import '../games/memory_game.dart';
import '../games/focus_training.dart';
import '../games/mood_tracker.dart';
import '../../chatbot/chatbot.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? fullName;

  @override
  void initState() {
    super.initState();
    print('✅ INIT STATE START');
    final user = Supabase.instance.client.auth.currentUser;
    print('📦 Supabase current user: $user');
    if (user == null) {
      print('⚠️ No user signed in!');
    } else {
      print('✅ Signed in user ID: ${user.id}');
    }
    fetchUserFullName();
    Future<List<dynamic>> loadProfessionals() async {
      final String jsonString =
          await rootBundle.loadString('assets/sources/medical_contacts.json');
      final List<dynamic> jsonData = json.decode(jsonString);
      return jsonData;
    }
  }

  Future<void> fetchUserFullName() async {
    final user = Supabase.instance.client.auth.currentUser;
    print("🔍 Fetching user full name...");

    if (user == null) {
      print("❌ Cannot fetch full name, user is null");
      return;
    }

    final response = await Supabase.instance.client
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();

    print("📥 Response from Supabase: $response");

    setState(() {
      fullName = response['fullname'];
      print("👋 Full name set to: $fullName");
    });
  }

  int _currentIndex = 0;

  final List<Map<String, dynamic>> _mentalHealthTopics = [
    {
      'title': 'Stress',
      'color': Color(0xFFFFC1CC),
      'icon': Icons.self_improvement,
      'quote': "Take a deep breath. You got this!"
    },
    {
      'title': 'Anxiety',
      'color': Color(0xFFB3E5FC),
      'icon': Icons.sentiment_dissatisfied,
      'quote': "Your mind is stronger than your anxiety."
    },
    {
      'title': 'Depression',
      'color': Color(0xFFB2DFDB),
      'icon': Icons.mood_bad,
      'quote': "Even the darkest night will pass, and the sun will rise."
    },
    {
      'title': 'OCD',
      'color': Color(0xFFD1C4E9),
      'icon': Icons.repeat,
      'quote': "You are not your intrusive thoughts."
    },
    {
      'title': 'PTSD',
      'color': Color(0xFFFFE0B2),
      'icon': Icons.flash_on,
      'quote': "Healing takes time, and that's okay."
    },
  ];

  final List<Map<String, dynamic>> _gamesList = [
    {
      'title': 'Memory game',
      'color': Color(0xFFFFCC80),
      'icon': Icons.memory,
      'page': MemoryBoostGame()
    },
    {
      'title': 'Are you focused?',
      'color': Color(0xFF81D4FA),
      'icon': Icons.remove_red_eye,
      'page': FocusTrainingGame()
    },
    {
      'title': 'Breathe slow',
      'color': Color(0xFFA5D6A7),
      'icon': Icons.air,
      'page': BreathingExerciseGame()
    },
    {
      'title': 'Positive Affirmations',
      'color': Color(0xFFB3E5FC),
      'icon': Icons.sentiment_satisfied,
      'page': PositiveAffirmationsGame()
    },
  ];

  final List<String> _positiveQuotes = [
    "Your mental health is a priority. Take care of it! 💙",
    "One small step each day leads to great healing. 🌱",
    "Breathe. You are stronger than you think. 🌸",
  ];


  Future<Position> getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location permissions are permanently denied.');
      }
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

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
                  if (fullName != null)
                    Padding(
                      padding: EdgeInsets.only(top: 4.0, left: 4.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Text(
                            'Welcome, $fullName!',
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontStyle: FontStyle.normal,
                              color: const Color.fromARGB(255, 6, 64, 130),
                            ),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 8),
                  Text(
                    _positiveQuotes[_currentIndex % _positiveQuotes.length],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
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
            _buildHorizontalList("Mental Health Topics", _mentalHealthTopics,
                (index) {
              String topic = _mentalHealthTopics[index]['title'];
              Widget targetScreen;

              switch (topic) {
                case 'Stress':
                  targetScreen = StressReliefScreen();
                  break;
                case 'Anxiety':
                  targetScreen = AnxietyReliefScreen();
                  break;
                case 'Depression':
                  targetScreen = DepressionReliefScreen(); // <- this line
                  break;
                case 'OCD':
                  targetScreen = OCDInfoScreen(); // <- this line
                  break;
                case 'PTSD':
                  targetScreen = PTSDInfoScreen(); // <- this line
                  break;
                // Add more as needed
                default:
                  targetScreen = Placeholder(); // fallback
              }

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => targetScreen),
              );
            }),
            SizedBox(height: 20),
            _buildHorizontalList("Mindful Games", _gamesList, (index) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => _gamesList[index]['page']),
              );
            }),
            SizedBox(height: 30),

            // Replace the entire `Expanded` block for "Professional Help" with this:
            SizedBox(
              height: 70, // Adjust height as needed
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MedicalContactsListScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFFB3E5FC),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.local_hospital, color: Colors.black87),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Reach out here to nearest therapists!",
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, size: 18),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalList(
      String title, List<Map<String, dynamic>> list, Function(int) onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 25, 39, 45)),
          ),
        ),
        SizedBox(height: 5),
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
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12, blurRadius: 5, spreadRadius: 2)
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(list[index]['icon'], size: 40, color: Colors.black),
                      SizedBox(height: 8),
                      Text(
                        list[index]['title'],
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 9, 54, 91),
                        ),
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
