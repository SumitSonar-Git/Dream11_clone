import 'package:dream_11_clone/Ui/home_screen.dart';
import 'package:dream_11_clone/Ui/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dream 11',
      theme: ThemeData(),
      home: AuthWrapper(),
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Check if the user is logged in or not
    User? user = FirebaseAuth.instance.currentUser; // Get the current user

    if (user != null) {
      // If a user is logged in, navigate to the HomeScreen
      return HomePage();
    } else {
      // If no user is logged in, navigate to the LoginScreen
      return LoginScreen();
    }
  }
}
