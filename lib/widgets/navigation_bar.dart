import 'package:flutter/material.dart';
import 'package:nava/screens/homepage.dart';
import 'package:nava/screens/profile_screen.dart';

class NavigationBarPage extends StatefulWidget {
  @override
  _NavigationBarPageState createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  int _selectedIndex = 0; // Başlangıçta HomePage gösterilecek

  final List<Widget> _pages = [
    HomePage(), // 0. index: HomePage
    ProfileScreen(), // 1. index: ProfileScreen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/nava.png',
              width: 30,
              height: 30,
            ),
            SizedBox(width: 10),
            Text('nava'),
          ],
        ),
      ),
      body: _pages[_selectedIndex], // Aktif sayfayı göster
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Hangi item seçili
        onTap: _onItemTapped, // Tap işlemi
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map', // HomePage
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile', // ProfileScreen
          ),
        ],
      ),
    );
  }
}
