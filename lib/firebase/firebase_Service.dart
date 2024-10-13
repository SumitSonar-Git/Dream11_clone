import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmail(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signup Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }
  }

  Future<User?> signInWithEmail(
      BuildContext context, String email, String password) async {
    try {
      // Firebase authentication for email and password
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // If sign-in succeeds, navigate to home screen
      Navigator.pushReplacementNamed(context, '/home');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logged-in successfully..'),
          backgroundColor: Colors.red,
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Print the error code and message to help debug the issue

      // Handling specific errors using error codes
      if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid ID or password, sign up instead.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    return null;
  }

  // Sign out user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> sendForgotPassMail(BuildContext context, String mail) async {
    try {
      await _auth.sendPasswordResetEmail(email: mail);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incorrect email: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
