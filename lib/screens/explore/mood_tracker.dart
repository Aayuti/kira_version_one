import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../widgets/mood_history.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({Key? key}) : super(key: key);

  @override
  State<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  String? selectedMood;
  List<String> selectedTags = [];

  final List<Map<String, String>> moods = [
    {'label': '😊 Happy', 'emoji': '😊'},
    {'label': '😢 Sad', 'emoji': '😢'},
    {'label': '😰 Anxious', 'emoji': '😰'},
    {'label': '😡 Angry', 'emoji': '😡'},
    {'label': '🤩 Excited', 'emoji': '🤩'},
    {'label': '😩 Stressed', 'emoji': '😩'},
  ];

  final List<String> tags = ['Work', 'Relationship', 'Health', 'School', 'Finance', 'Other'];

  Future<void> _submitMood() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null || selectedMood == null) return;

    try {
      await Supabase.instance.client.from('moods').insert({
        'user_id': user.id,
        'mood': selectedMood,
        'tags': selectedTags,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mood saved!")),
      );
      setState(() {
        selectedMood = null;
        selectedTags.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  void _goToMoodHistory() {
    Navigator.pushNamed(context, '/moodHistory'); // Make sure this route exists
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F0), // soft pastel background
      appBar: AppBar(
        title: const Text('Mood Tracker'),
        backgroundColor: const Color(0xFFFFC1CC), // pastel pink
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "How are you feeling today?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: moods.map((mood) {
                final label = mood['label']!;
                final isSelected = selectedMood == label;
                return ChoiceChip(
                  label: Text(label, style: const TextStyle(fontSize: 16)),
                  selected: isSelected,
                  selectedColor: const Color(0xFFFFD3E0),
                  backgroundColor: const Color(0xFFF8F8F8),
                  onSelected: (_) => setState(() => selectedMood = label),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.black : Colors.grey[700],
                  ),
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            const Text("What is this mood related to?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              children: tags.map((tag) {
                final isSelected = selectedTags.contains(tag);
                return FilterChip(
                  label: Text(tag),
                  selected: isSelected,
                  selectedColor: const Color(0xFFB2EBF2),
                  backgroundColor: const Color(0xFFE0F7FA),
                  onSelected: (selected) {
                    setState(() {
                      isSelected ? selectedTags.remove(tag) : selectedTags.add(tag);
                    });
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.black : Colors.grey[800],
                  ),
                );
              }).toList(),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _submitMood,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB5EAD7),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("Submit Mood", style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: _goToMoodHistory,
                child: const Text("View Mood History ➜",
                    style: TextStyle(fontSize: 15, color: Colors.blueAccent)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
