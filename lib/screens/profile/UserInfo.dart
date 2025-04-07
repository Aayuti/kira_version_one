import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String fullName = '';
  String email = '';
  int points = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user != null) {
      final response = await Supabase.instance.client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (response != null) {
        setState(() {
          fullName = response['fullname'] ?? 'No Name';
          email = response['email'] ?? 'No Email';
          points = response['points'] ?? 0; // Ensure you have this column
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    }

    return Column(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundColor: Color.fromARGB(255, 202, 202, 202),
          child: Icon(Icons.person, size: 40, color: Colors.white),
        ),
        const SizedBox(height: 10),
        Text(fullName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(email, style: const TextStyle(fontSize: 16, color: Colors.grey)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Points:", style: TextStyle(fontSize: 16)),
            const SizedBox(width: 5),
            CircleAvatar(
              radius: 12,
              backgroundColor: const Color.fromARGB(255, 63, 54, 244),
              child: Text(points.toString(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    );
  }
}
