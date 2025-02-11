import 'package:flutter/material.dart';
import 'package:nava/screens/profile_screen.dart';
import 'package:nava/screens/homepage.dart';
import 'package:nava/screens/statistics.dart'; // Importing the new page

class NavigationBarPage extends StatefulWidget {
  @override
  _NavigationBarPageState createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    StatisticsPage(),
    ProfileScreen(),
    // Add the Statistics page here
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 69, 22, 30),
        selectedItemColor: Color(0xFFFFF8DC),
        unselectedItemColor: Color(0xFFFFF8DC).withOpacity(0.6),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart), // Pie chart icon for statistics
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
