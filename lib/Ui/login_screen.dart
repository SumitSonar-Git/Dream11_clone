import 'package:dream_11_clone/Ui/forgotpass_screen.dart';
import 'package:dream_11_clone/Ui/signup_screen.dart';
import 'package:dream_11_clone/firebase/firebase_Service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailText = TextEditingController();
  TextEditingController passText = TextEditingController();

// Firebase instance

  bool _obscureText = true;
  String passSuggestion = '';

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery to get screen size
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/loginpic.png'),
                SizedBox(height: 40),
                Container(
                  width: screenWidth < 600 ? screenWidth * 0.9 : 400,
                  child: TextFormField(
                    controller: emailText,
                    decoration: InputDecoration(
                      labelText: 'Username/ID',
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: screenWidth < 600 ? screenWidth * 0.9 : 400,
                  child: TextFormField(
                    controller: passText,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          icon: Icon(_obscureText
                              ? Icons.visibility_off
                              : Icons.visibility)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        passSuggestion,
                        style: TextStyle(color: Colors.red),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotpassScreen()));
                        },
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: screenWidth < 600 ? screenWidth * 0.9 : 200,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        FirebaseService service = FirebaseService();
                        await service.signInWithEmail(
                            context, emailText.text, passText.text);
                        // Form is valid, proceed to next screen or logic
                      }

                      // Use named route for navigation
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("New user? "),
                    GestureDetector(
                      onTap: () {
                        // Navigate to SignUpScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                      child: Text(
                        'Register here',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
