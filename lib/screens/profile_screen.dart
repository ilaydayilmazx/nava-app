import 'package:flutter/material.dart';
import 'package:nava/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore import
import 'package:fluttertoast/fluttertoast.dart';

class ProfileScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance; // FirebaseAuth instance
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Firestore instance

  @override
  Widget build(BuildContext context) {
    User? currentUser = _auth.currentUser; // Giriş yapan kullanıcıyı al

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8DC), // Arka plan rengi
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 69, 22, 30), // AppBar rengi
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/nava.png', // Logo
              height: 40,
            ),
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
              await _auth.signOut(); // Firebase'den çıkış yap
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LoginScreen()), // Çıkış yapınca login ekranına git
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
                  backgroundImage: AssetImage(
                      'assets/profile_picture.png'), // Profil fotoğrafı
                ),
                const SizedBox(height: 16),
                Text(
                  currentUser?.email ?? 'No Email', // E-posta adresi
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
                        _showChangePasswordDialog(
                            context); // Şifre değiştirme penceresini göster
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
          const Divider(), // Ayırıcı çizgi
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('posts')
                  .where('userId',
                      isEqualTo: currentUser
                          ?.uid) // Sadece kullanıcının postlarını getir
                  .orderBy('timestamp',
                      descending: true) // Postları zaman sırasına göre sırala
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child:
                          CircularProgressIndicator()); // Yükleniyor göstergesi
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      "No posts yet!", // Eğer post yoksa
                      style: TextStyle(
                        fontFamily: 'Sarina',
                        fontSize: 18,
                        color: Color(0xFFB3001E),
                      ),
                    ),
                  );
                }

                final posts = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index].data() as Map<String, dynamic>;
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mood: ${post['emotion'] ?? 'Unknown'}", // Mood (duygular)
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                "Music: ${post['music'] ?? 'Unknown'}"), // Müzik
                            Text(
                                "Location: ${post['province'] ?? 'Unknown'}"), // İlçe
                            Text(
                              "Time: ${post['timestamp'] != null ? (post['timestamp'] as Timestamp).toDate().toString() : 'Unknown'}", // Zaman
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _deletePost(posts[index].id); // Postu silme
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Şifre değiştirme fonksiyonu
  void _showChangePasswordDialog(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: TextField(
            controller: passwordController,
            obscureText: true, // Şifreyi gizle
            decoration: const InputDecoration(hintText: 'Enter new password'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Dialog penceresini kapat
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                String newPassword = passwordController.text.trim();
                if (newPassword.isNotEmpty) {
                  try {
                    User? user = FirebaseAuth.instance.currentUser;
                    await user?.updatePassword(newPassword); // Şifreyi güncelle
                    await user?.reload(); // Kullanıcıyı yeniden yükle
                    Fluttertoast.showToast(
                        msg: "Password changed successfully!"); // Başarı mesajı
                  } catch (e) {
                    Fluttertoast.showToast(msg: "Error: $e"); // Hata mesajı
                  }
                }
                Navigator.pop(context); // Dialog penceresini kapat
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Postu silme fonksiyonu
  void _deletePost(String postId) async {
    try {
      await _firestore
          .collection('posts')
          .doc(postId)
          .delete(); // Firestore'dan postu sil
      Fluttertoast.showToast(
          msg: "Post deleted successfully!"); // Başarı mesajı
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e"); // Hata mesajı
    }
  }
}
