import 'package:flutter/material.dart';

class MentalHealthTopicScreen extends StatelessWidget {
  final String topic;
  final String quote;
  final Color backgroundColor;

  MentalHealthTopicScreen({
    required this.topic,
    required this.quote,
    required this.backgroundColor, required title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(topic),
        backgroundColor: backgroundColor.withOpacity(0.8),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            quote,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
