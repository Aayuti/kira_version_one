import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'AddFriendScreen.dart';

class ContactsList extends StatelessWidget {
  final List<String> contacts = [
    "Alice", "Bob", "Charlie", "David", "Emma"
  ];

  ContactsList({Key? key}) : super(key: key);

  // ✅ Function to add friend persistently
  Future<void> _addFriend(String name, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final String? friendsJson = prefs.getString('friendsList');
    List<String> friends = friendsJson != null ? List<String>.from(jsonDecode(friendsJson)) : [];

    if (!friends.contains(name)) {
      friends.add(name);
      await prefs.setString('friendsList', jsonEncode(friends));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.pink[100], // Restore pink background
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (String contact in contacts)
            ListTile(
              leading: Icon(Icons.person, color: Colors.black), // ✅ Human icon
              title: Text(contact),
              trailing: GestureDetector(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => AddFriendScreen(
                    contactName: contact,
                    onConfirmAdd: (name) => _addFriend(name, context),
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[300], // ✅ Grey circle
                  child: Icon(Icons.add, color: Colors.black),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
