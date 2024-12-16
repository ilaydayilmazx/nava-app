import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../service/post_service.dart';

class HomePage extends StatelessWidget {
  final PostService _postService = PostService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 69, 22, 30), // Üst alan rengi
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/nava.png', // Logo yolu (assets içinde yer almalı)
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
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return InteractiveViewer(
            boundaryMargin: EdgeInsets.zero,
            minScale: 1.0,
            maxScale: 5.0,
            constrained: false,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 3, // SVG genişliği
              height: constraints.maxHeight, // SVG yüksekliği
              child: SvgPicture.asset(
                'assets/istanbul.svg',
                fit: BoxFit.fitHeight,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddPostDialog(context);
        },
        backgroundColor: Color(0xFFB3001E),
        child: Icon(Icons.add, color: Color(0xFFFFF8DC)),
      ),
    );
  }

  void _showAddPostDialog(BuildContext context) {
    TextEditingController musicController = TextEditingController();
    String? selectedEmotion;
    String? selectedProvince;
    final List<String> emotions = [
      'Angry',
      'Anxious',
      'Sad',
      'Neutral',
      'Excited',
      'Happy',
      'Chill'
    ];
    final List<String> provinces = [
      'Adalar',
      'Arnavutkoy',
      'Atasehir',
      'Avcilar',
      'Bagcilar',
      'Bahcelievler',
      'Bakirkoy',
      'Basaksehir',
      'Bayrampasa',
      'Besiktas',
      'Beykoz',
      'Beylikduzu',
      'Beyoglu',
      'Buyukcekmece',
      'Catalca',
      'Cekmekoy',
      'Esenler',
      'Esenyurt',
      'Eyupsultan',
      'Fatih',
      'Gaziosmanpasa',
      'Gungoren',
      'Kadikoy',
      'Kagithane',
      'Kartal',
      'Kucukcekmece',
      'Maltepe',
      'Pendik',
      'Sancaktepe',
      'Sariyer',
      'Silivri',
      'Sultanbeyli',
      'Sultangazi',
      'Sisli',
      'Tuzla',
      'Umraniye',
      'Uskudar',
      'Zeytinburnu'
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create Post'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Emotion:'),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: emotions.map((emotion) {
                    return ChoiceChip(
                      label: Text(emotion),
                      selected: selectedEmotion == emotion,
                      onSelected: (selected) {
                        selectedEmotion = selected ? emotion : null;
                        (context as Element)
                            .markNeedsBuild(); // UI güncellemesi
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                Text('Select Province:'),
                DropdownButton<String>(
                  value: selectedProvince,
                  hint: Text('Select a district'),
                  isExpanded: true,
                  items: provinces.map((province) {
                    return DropdownMenuItem(
                      value: province,
                      child: Text(province),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedProvince = value;
                    (context as Element).markNeedsBuild(); // UI güncellemesi
                  },
                ),
                SizedBox(height: 16),
                TextField(
                  controller: musicController,
                  decoration: InputDecoration(hintText: 'Enter music name'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                String musicName = musicController.text.trim();
                String time =
                    DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
                User? currentUser = FirebaseAuth.instance.currentUser;

                if (selectedEmotion != null &&
                    selectedProvince != null &&
                    musicName.isNotEmpty &&
                    currentUser != null) {
                  await _postService.createPost(
                    userId: currentUser.uid,
                    emotion: selectedEmotion!,
                    province: selectedProvince!,
                    music: musicName,
                    time: time,
                  );
                  Navigator.pop(context);
                } else {
                  print('All fields must be filled');
                }
              },
              child: Text('Post'),
            ),
          ],
        );
      },
    );
  }
}
