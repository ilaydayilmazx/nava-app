import 'package:flutter/material.dart';
import 'package:nava/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8DC),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 69, 22, 30),
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/nava.png',
              height: 40,
            ),
            SizedBox(width: 8),
            Text(
              'nava',
              style: TextStyle(
                fontFamily: 'Sarina',
                fontSize: 24,
                color: Color(0xFFFFF8DC),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Color(0xFFFFF8DC)),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile_picture.png'),
                ),
                SizedBox(height: 16),
                Text(
                  'Username',
                  style: TextStyle(
                    fontFamily: 'Sarina',
                    fontSize: 24,
                    color: Color(0xFFB3001E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Password',
                      style: TextStyle(
                        fontFamily: 'Sarina',
                        fontSize: 18,
                        color: Color(0xFFB3001E).withOpacity(0.8),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _showChangePasswordDialog(context);
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Color(0xFFB3001E),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(hintText: 'Enter new password'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                print('New password: ${passwordController.text}');
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
