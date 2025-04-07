import 'package:flutter/material.dart';
import 'package:kira_version_one/screens/auth/phone_auth_screen.dart';
import 'package:kira_version_one/screens/profile/ProfileScreen.dart';
import 'package:kira_version_one/utils/otp_verify.dart';
import 'package:kira_version_one/widgets/medical_contacts_list.dart';
import 'package:kira_version_one/widgets/mood_history.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kira_version_one/screens/auth/login_screen.dart';
import 'package:kira_version_one/screens/auth/registration_screen.dart';
import 'package:kira_version_one/screens/main_screen.dart';  // Import MainScreen
import 'package:kira_version_one/screens/splash_screen.dart';
import 'utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Supabase.initialize(
    url: 'https://obbtvjfuzexaadzzwdul.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9iYnR2amZ1emV4YWFkenp3ZHVsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc0NjkxMDUsImV4cCI6MjA1MzA0NTEwNX0.JNDHgMjbu9d2OmhK024MfPaUfeohYfKxmccpq5LLuBU',
  );
  runApp(MentalHealthApp());
}

// Future<void> main() async {AQQQQQ
//   runApp(MentalHealthApp());
// }

class MentalHealthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {  
    return MaterialApp(
      title: 'Mental Health Support',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegistrationScreen(),
        '/splash': (context) => SplashScreen(),
        '/home': (context) => MainScreen(), 
        '/profile': (context) => ProfileScreen(),
        '/phoneAuth': (_) => PhoneAuthScreen(),
        '/verify_otp': (_) => OtpVerificationScreen(),
        '/moodHistory': (_) => MoodHistoryScreen(),
        '/professionalHelp': (_) => MedicalContactsListScreen()
      },
    );
  }
}
