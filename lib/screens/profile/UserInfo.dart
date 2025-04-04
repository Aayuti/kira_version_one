import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, size: 40, color: Colors.white),
        ),
        SizedBox(height: 10),
        Text("_aliceAux", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text("Alice Aux", style: TextStyle(fontSize: 16, color: Colors.grey)),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Points:", style: TextStyle(fontSize: 16)),
            SizedBox(width: 5),
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.red,
              child: Text("5", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    );
  }
}
