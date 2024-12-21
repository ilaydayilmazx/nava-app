import 'package:flutter/material.dart';
import 'package:nava/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore import
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nava/service/post_service.dart'; // PostService import

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // FirebaseAuth instance
  final PostService _postService = PostService(); // PostService instance

  List<Map<String, dynamic>> _posts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPosts(); // Kullanıcı postlarını çek
  }

  void _fetchPosts() async {
    try {
      User? currentUser = _auth.currentUser;
      final posts = await _postService.getUserPosts(currentUser?.uid ?? '');
      setState(() {
        _posts = posts;
        _isLoading = false;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Error loading posts: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _deletePost(String postId) async {
    try {
      await _postService.deletePost(postId); // Firestore'dan sil
      Fluttertoast.showToast(msg: "Post deleted successfully!");
      setState(() {
        _posts.removeWhere((post) => post['id'] == postId); // Listeden sil
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Error deleting post: $e");
    }
  }

  void _showChangePasswordDialog(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(hintText: 'Enter new password'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                String newPassword = passwordController.text.trim();
                if (newPassword.isNotEmpty) {
                  try {
                    User? user = FirebaseAuth.instance.currentUser;
                    await user?.updatePassword(newPassword);
                    await user?.reload();
                    Fluttertoast.showToast(
                        msg: "Password changed successfully!");
                  } catch (e) {
                    Fluttertoast.showToast(msg: "Error: $e");
                  }
                }
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = _auth.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8DC),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 69, 22, 30),
        elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/nava.png', height: 40),
            const SizedBox(width: 8),
            const Text(
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
            icon: const Icon(Icons.logout, color: Color(0xFFFFF8DC)),
            onPressed: () async {
              await _auth.signOut();
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
                const CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage('assets/profile_picture.png'), // Profil foto
                ),
                const SizedBox(height: 16),
                Text(
                  currentUser?.email ?? 'No Email',
                  style: const TextStyle(
                    fontFamily: 'Sarina',
                    fontSize: 24,
                    color: Color(0xFFB3001E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Password',
                      style: TextStyle(
                        fontFamily: 'Sarina',
                        fontSize: 18,
                        color: const Color(0xFFB3001E).withOpacity(0.8),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _showChangePasswordDialog(context);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Color(0xFFB3001E),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _posts.isEmpty
                    ? const Center(
                        child: Text(
                          "No posts yet!",
                          style: TextStyle(
                            fontFamily: 'Sarina',
                            fontSize: 18,
                            color: Color(0xFFB3001E),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _posts.length,
                        itemBuilder: (context, index) {
                          final post = _posts[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mood: ${post['emotion'] ?? 'Unknown'}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("Music: ${post['music'] ?? 'Unknown'}"),
                                  Text(
                                      "Location: ${post['province'] ?? 'Unknown'}"),
                                  Text(
                                    "Time: ${post['time']?.toDate().toString() ?? 'Unknown'}",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () {
                                        _deletePost(post['id']);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
