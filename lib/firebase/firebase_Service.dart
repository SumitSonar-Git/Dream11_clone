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
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signin error: $e'),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }
  }

  // Sign out user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> sendOTP(BuildContext context, String phoneNumber,
      Function(String verificationId, int? resendToken) onCodeSent) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber, // You missed adding this required parameter
      timeout: const Duration(
          seconds: 60), // Set a timeout for the verification process
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Phone number automatically verified and user signed in: ${credential.smsCode}')),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Phone verification failed: ${e.message}'),
            backgroundColor: Colors.red,
          ),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        // This callback gets called when the OTP is sent successfully
        onCodeSent(verificationId, resendToken);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP sent to $phoneNumber')),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP retrieval timeout')),
        );
      },
    );
  }

  Future<User?> verifyOTP(
      BuildContext context, String verificationId, String smsCode) async {
    try {
      // Create a PhoneAuthCredential with the verificationId and smsCode
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      // Sign in with the credential
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'OTP verified successfully. Signed in as: ${userCredential.user?.phoneNumber}')),
      );
      return userCredential.user;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('OTP verification error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }
  }
}
