import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'AddFriendScreen.dart';

class ContactsList extends StatelessWidget {
  final List<String> contacts = [
    "Archi Mehta", "Vilma Xavier", "Isha Agrawal", "Alethea Rangaya", "Kirti Shinde"
  ];

  ContactsList({Key? key}) : super(key: key);

  // Add friend persistently
  Future<void> _addFriend(String name, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final String? friendsJson = prefs.getString('friendsList');
    List<String> friends = friendsJson != null
        ? List<String>.from(jsonDecode(friendsJson))
        : [];

    if (!friends.contains(name)) {
      friends.add(name);
      await prefs.setString('friendsList', jsonEncode(friends));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: contacts.map((contact) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                backgroundColor: Colors.pink[200],
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                contact,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              trailing: GestureDetector(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => AddFriendScreen(
                    contactName: contact,
                    onConfirmAdd: (name) => _addFriend(name, context),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.pinkAccent, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pinkAccent.withOpacity(0.2),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(Icons.add, color: Colors.pinkAccent, size: 20),
                  // 👉 or use your PNG icon like this:
                  // child: Image.asset('assets/icons/add.png', height: 20),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
