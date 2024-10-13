import 'package:dream_11_clone/firebase/firebase_Service.dart';
import 'package:flutter/material.dart';

class ForgotpassScreen extends StatefulWidget {
  const ForgotpassScreen({super.key});

  @override
  State<ForgotpassScreen> createState() => _ForgotpassScreenState();
}

class _ForgotpassScreenState extends State<ForgotpassScreen> {
  final emailText = TextEditingController();

  FirebaseService _firebaseService = FirebaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Enter email to send you a password reset mail",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 70,
                  width: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailText,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            "Enter your email",
                            style: TextStyle(fontSize: 15),
                          )),
                    ),
                  )),
            ),
            ElevatedButton(
              onPressed: () {
                _firebaseService.sendForgotPassMail(context, emailText.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Email sent Successfully'),
                    backgroundColor: Colors.red,
                  ),
                );
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text(
                "Send Mail",
                style: TextStyle(color: Colors.black),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange)),
            )
          ],
        ),
      ),
    );
  }
}
