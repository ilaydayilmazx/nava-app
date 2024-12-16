import 'package:flutter/material.dart';
import 'package:nava/service/auth.dart'; // Auth servisinizin yolu
import 'package:fluttertoast/fluttertoast.dart'; // Toast mesajları için

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>(); // Form için global key
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // FirebaseAuth servisini kullanmak için bir instance
  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB3001E), // Kırmızı arka plan
      body: Column(
        children: [
          // Üst kırmızı alan (gradient)
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 87, 1, 15), // Koyu kırmızı
                  const Color.fromARGB(255, 128, 2, 23), // Daha açık kırmızı
                  const Color.fromARGB(255, 179, 0, 30)
                      .withOpacity(0.1), // Açık kırmızı
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [0.0, 0.6, 1.0],
              ),
            ),
          ),
          // Alt sarı alan (Container) ve köşe yuvarlatma
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFFF8DC), // Sarı arka plan
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), // Üst sol köşe yuvarlatma
                  topRight: Radius.circular(30), // Üst sağ köşe yuvarlatma
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Column(
                    children: [
                      Image.asset(
                        'assets/nava.png', // Logo yolu (assets içine yerleştirilmeli)
                        height: 150,
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                  // Register yazısı
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontFamily: 'Sarina', // Sarina fontu
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB3001E),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Form alanları
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Form(
                      key: _formKey, // Formun global key'i
                      child: Column(
                        children: [
                          // Email TextField
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: const Color(0xFFB3001E).withOpacity(0.6),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFB3001E)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              // Email format doğrulaması
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Password TextField
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: const Color(0xFFB3001E).withOpacity(0.6),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFB3001E)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Confirm Password TextField
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(
                                color: const Color(0xFFB3001E).withOpacity(0.6),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFB3001E)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Register Butonu
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        try {
                          // Kullanıcı kaydını yap
                          await _auth.createUser(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );

                          // Başarı mesajı
                          Fluttertoast.showToast(
                            msg: "Registration successful",
                            toastLength: Toast.LENGTH_SHORT,
                          );

                          Navigator.pop(context); // Login ekranına geri dön
                        } catch (e) {
                          // Hata mesajı
                          Fluttertoast.showToast(
                            msg: "Error: $e",
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB3001E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontFamily: 'Sarina', // Sarina fontu
                        color: Color(0xFFFFF8DC),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
