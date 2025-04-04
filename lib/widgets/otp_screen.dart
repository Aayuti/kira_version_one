// lib/screens/otp_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OtpScreen extends StatefulWidget {
  final String email; // Receive the email from the previous screen

  OtpScreen({required this.email});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  String _errorMessage = '';

  Future<void> _verifyOtp() async {
    setState(() {
      _errorMessage = ''; // Clear previous error messages
    });

    try {
      final response = await Supabase.instance.functions.invoke(
        'verify_otp',
        body: {'email': widget.email, 'otp': _otpController.text},
      );

      if (response.data['authenticated'] == true) {
        // OTP verified, authenticate user
        await Supabase.instance.client.auth.signInWithPassword(
          email: widget.email,
          password: 'dummy_password', // Or retrieve/create a password
        );

        // Navigate to the next screen (e.g., home screen)
        Navigator.pushReplacementNamed(context, '/home'); // Replace '/home' with your home route.
      } else {
        setState(() {
          _errorMessage = 'Invalid OTP';
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'Error verifying OTP: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'OTP'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _verifyOtp,
              child: Text('Verify OTP'),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}