import 'package:flutter/material.dart';

class PTSDInfoScreen extends StatelessWidget {
  const PTSDInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA), // soft teal background
      appBar: AppBar(
        backgroundColor: const Color(0xFF80DEEA),
        title: const Text('Understanding PTSD'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'What is PTSD?',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'PTSD (Post-Traumatic Stress Disorder) is a mental health condition triggered by experiencing or witnessing a traumatic event. It can cause flashbacks, nightmares, and severe anxiety.',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _sectionCard(
                title: 'Symptoms',
                items: [
                  'Flashbacks or reliving the trauma',
                  'Avoiding reminders of the trauma',
                  'Hypervigilance or always feeling on edge',
                  'Emotional numbness',
                  'Disturbed sleep or nightmares',
                ],
              ),
              const SizedBox(height: 20),
              _sectionCard(
                title: 'Coping Strategies',
                items: [
                  'Deep breathing or mindfulness exercises',
                  'Grounding techniques (5-4-3-2-1 method)',
                  'Talking to trusted friends or therapists',
                  'Physical activity like walking or yoga',
                  'Maintaining a consistent sleep routine',
                ],
              ),
              const SizedBox(height: 20),
              _sectionCard(
                title: 'Helpful Resources',
                items: [
                  '🌐 [National Center for PTSD](https://www.ptsd.va.gov/)',
                  '📞 [iCall India](https://icallhelpline.org/) – Free counseling',
                  '📘 "The Body Keeps the Score" by Bessel van der Kolk',
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFB2EBF2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '🌟 Healing is not linear. Be patient and kind to yourself. You’re doing better than you think.',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _sectionCard({required String title, required List<String> items}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 10),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('• $item', style: const TextStyle(fontSize: 16)),
              )),
        ],
      ),
    );
  }
}
