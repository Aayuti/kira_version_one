import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';

class MoodHistoryScreen extends StatefulWidget {
  const MoodHistoryScreen({super.key});

  @override
  State<MoodHistoryScreen> createState() => _MoodHistoryScreenState();
}

class _MoodHistoryScreenState extends State<MoodHistoryScreen> {
  final Map<String, int> moodLevels = {
    '😊 Happy': 5,
    '🤩 Excited': 4,
    '😩 Stressed': 3,
    '😰 Anxious': 2,
    '😢 Sad': 1,
    '😡 Angry': 0,
  };

  List<FlSpot> moodSpots = [];
  List<String> dateLabels = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    _fetchMoodData();
  }

  Future<void> _fetchMoodData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final response = await Supabase.instance.client
        .from('moods')
        .select()
        .eq('user_id', user.id)
        .order('created_at');

    List<dynamic> moods = response;

    List<FlSpot> tempSpots = [];
    List<String> tempDates = [];

    for (int i = 0; i < moods.length; i++) {
      final moodLabel = moods[i]['mood'];
      final moodValue = moodLevels[moodLabel] ?? 0;

      tempSpots.add(FlSpot(i.toDouble(), moodValue.toDouble()));

      final createdAt = DateTime.parse(moods[i]['created_at']);
      tempDates.add("${createdAt.day}/${createdAt.month}");
    }

    setState(() {
      moodSpots = tempSpots;
      dateLabels = tempDates;
      loading = false;
    });
  }

  Widget buildChart() {
    if (moodSpots.isEmpty) {
      return const Center(child: Text("No mood data available."));
    }

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: LineChart(
                    LineChartData(
                      minY: 0,
                      maxY: 5,
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, _) {
                              final mood = moodLevels.entries
                                  .firstWhere((e) => e.value == value.toInt(),
                                      orElse: () => const MapEntry('?', 0))
                                  .key;
                              return Text(mood.split(" ")[1],
                                  style: const TextStyle(fontSize: 12));
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, _) {
                              if (value.toInt() < dateLabels.length) {
                                return Text(dateLabels[value.toInt()],
                                    style: const TextStyle(fontSize: 10));
                              }
                              return const Text('');
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: moodSpots,
                          isCurved: true,
                          color: const Color(0xFF87CEFA),
                          belowBarData: BarAreaData(
                            show: true,
                            color: const Color(0xFFB3E5FC).withOpacity(0.3),
                          ),
                          dotData: FlDotData(show: true),
                        )
                      ],
                    ),
                  ),
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3F6),
      appBar: AppBar(
        title: const Text("Mood History"),
        backgroundColor: const Color(0xFFFFC1CC),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const Text("Mood over time",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Expanded(child: buildChart()),
                ],
              ),
      ),
    );
  }
}
