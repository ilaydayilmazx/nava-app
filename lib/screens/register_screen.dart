import 'package:flutter/material.dart';
import 'package:nava/screens/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Save işlemi
            Navigator.pop(context); // Login'e geri dön
          },
          child: Text('Save'),
        ),
      ),
    );
  }
}
