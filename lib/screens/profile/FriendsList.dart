import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FriendsList extends StatefulWidget {
  const FriendsList({Key? key}) : super(key: key);

  @override
  _FriendsListState createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  List<String> friends = [];

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  // ✅ Load friends from SharedPreferences
  Future<void> _loadFriends() async {
    final prefs = await SharedPreferences.getInstance();
    final String? friendsJson = prefs.getString('friendsList');
    if (friendsJson != null) {
      setState(() {
        friends = List<String>.from(jsonDecode(friendsJson));
      });
    }
  }

  // ✅ Save friends to SharedPreferences
  Future<void> _saveFriends() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('friendsList', jsonEncode(friends));
  }

  // ✅ Remove friend and update storage
  void _removeFriend(String name) {
    setState(() {
      friends.remove(name);
      _saveFriends(); // Save updated list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue[100], // Restore blue background
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (String friend in friends)
            ListTile(
              leading: Icon(Icons.person, color: Colors.black),
              title: Text(friend),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _removeFriend(friend),
              ),
            ),
        ],
      ),
    );
  }
}
