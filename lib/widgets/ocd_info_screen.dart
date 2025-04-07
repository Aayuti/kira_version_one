import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OCDInfoScreen extends StatelessWidget {
  const OCDInfoScreen({Key? key}) : super(key: key);

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Understanding OCD'),
        backgroundColor: Colors.pink.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/stickers/ocd.gif', // optional image
                height: 150,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'What is OCD?',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.pink.shade300,
                  ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Obsessive-Compulsive Disorder (OCD) is a mental health condition that causes repeated unwanted thoughts (obsessions) and behaviors (compulsions). It’s okay to seek help — you’re not alone.',
            ),
            const SizedBox(height: 24),
            Text(
              'Common Symptoms:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            const BulletList(items: [
              'Repetitive thoughts about germs, harm, or symmetry',
              'Excessive hand washing or cleaning',
              'Needing things in a specific order',
            ]),
            const SizedBox(height: 24),
            Text(
              'Coping Strategies:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            const BulletList(items: [
              'Practice deep breathing or mindfulness',
              'Set small, achievable goals',
              'Avoid reassurance-seeking',
              'Learn about Exposure & Response Prevention (ERP)',
            ]),
            const SizedBox(height: 24),
            Text(
              'Learn More:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () => _launchURL('https://iocdf.org'),
              child: const Text('International OCD Foundation'),
            ),
            TextButton(
              onPressed: () => _launchURL('https://www.nhs.uk/mental-health/conditions/obsessive-compulsive-disorder-ocd/overview/'),
              child: const Text('NHS: OCD Overview'),
            ),
            const SizedBox(height: 32),
            Center(
              child: Text(
                '“Everyone’s journey is different. Whether you’re managing OCD or supporting someone who is, you’re doing great.”',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade600,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade100,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/professionalHelp');
                },
                child: const Text('Need Support?'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> items;
  const BulletList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('•  ', style: TextStyle(fontSize: 20)),
                    Expanded(child: Text(item)),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
