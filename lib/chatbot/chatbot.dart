import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];
  final String apiUrl = "https://kira-chatbot-v1.onrender.com/chat"; 
  void sendMessage() async {
  String userMessage = _controller.text;
  if (userMessage.isEmpty) return;

  if (!mounted) return; // Prevent setState() if widget is disposed

  setState(() {
    messages.add({"sender": "user", "message": userMessage});
    _controller.clear();
  });
  
  try {
    print("Sending request to $apiUrl with message: $userMessage");

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"input_text": userMessage}),  // FIXED FIELD NAME
    );

    print("Response Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (!mounted) return; // Prevent setState() if widget is disposed

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        messages.add({"sender": "bot", "message": data["response"] ?? "I didn't understand that."});
      });
    } else {
      setState(() {
        messages.add({"sender": "bot", "message": "Error: Server returned ${response.statusCode}."});
      });
    }
  } catch (e) {
    print("Error: $e");
    if (!mounted) return; // Prevent setState() if widget is disposed
    setState(() {
      messages.add({"sender": "bot", "message": "Error: Unable to connect to chatbot."});
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chatbot"), backgroundColor: const Color.fromARGB(255, 187, 248, 246)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isUser = messages[index]["sender"] == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: isUser ? const Color.fromARGB(255, 187, 248, 246) : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(messages[index]["message"]!,
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 187, 248, 246),
                  child: Icon(Icons.send, color: Colors.white),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
