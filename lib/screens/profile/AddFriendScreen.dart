import 'package:flutter/material.dart';

class AddFriendScreen extends StatelessWidget {
  final String contactName;
  final Function(String) onConfirmAdd; // Function to add friend

  const AddFriendScreen({Key? key, required this.contactName, required this.onConfirmAdd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Friend"),
      content: Text("Do you want to add $contactName to your friends list?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close alert
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            onConfirmAdd(contactName); // Add friend to list
            Navigator.pop(context); // Close alert
          },
          child: Text("Confirm"),
        ),
      ],
    );
  }
}
