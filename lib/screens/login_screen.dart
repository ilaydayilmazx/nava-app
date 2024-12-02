import 'package:flutter/material.dart';
import 'package:nava/screens/register_screen.dart';
import 'package:nava/widgets/navigation_bar.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB3001E), // Kırmızı arka plan
      body: Column(
        children: [
          // Üst kırmızı alan (gradient)
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 87, 1, 15), // Koyu kırmızı
                  Color.fromARGB(255, 128, 2, 23), // Koyu kırmızı
                  Color.fromARGB(255, 179, 0, 30).withOpacity(0.1), // Açık kırmızı
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
              decoration: BoxDecoration(
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
                      SizedBox(height: 32),
                    ],
                  ),
                  // Login yazısı
                  Text(
                    'login',
                    style: TextStyle(
                      fontFamily: 'Sarina', // Sarina fontu
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB3001E),
                    ),
                  ),
                  SizedBox(height: 16),
                  // E-mail ve Password TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              color: Color(0xFFB3001E).withOpacity(0.6),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFB3001E)),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: Color(0xFFB3001E).withOpacity(0.6),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFB3001E)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  // Butonlar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFB3001E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                        child: Text(
                          'sign up',
                          style: TextStyle(
                            fontFamily: 'Sarina', // Sarina fontu
                            color: Color(0xFFFFF8DC),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavigationBarPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFB3001E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                        child: Text(
                          'sign in',
                          style: TextStyle(
                            fontFamily: 'Sarina', // Sarina fontu
                            color: Color(0xFFFFF8DC),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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