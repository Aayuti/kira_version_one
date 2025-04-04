import 'package:flutter/material.dart';

class MemoryBoostGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Memory Boost Game")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Match the cards!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Icon(Icons.memory, size: 100, color: Colors.orange),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Memory Challenge Coming Soon!"),
                ));
              },
              child: Text("Play"),
            ),
          ],
        ),
      ),
    );
  }
}
