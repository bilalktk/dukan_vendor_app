import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            await _auth.signOut();
          },
          child: const Text(
            'Signout',
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 4,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
