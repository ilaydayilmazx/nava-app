import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../service/post_service.dart';
import '../service/spotify_service.dart';

class HomePage extends StatelessWidget {
  final PostService _postService = PostService();
  final SpotifyService _spotifyService = SpotifyService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return InteractiveViewer(
            boundaryMargin: EdgeInsets.zero,
            minScale: 1.0,
            maxScale: 5.0,
            constrained: false,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 3,
              height: constraints.maxHeight,
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
    final List<Map<String, dynamic>> emotions = [
      {
        'emotion': 'Angry',
        'color': const Color.fromARGB(255, 160, 2, 26),
        'emoji': '😡'
      },
      {'emotion': 'Anxious', 'color': Colors.red, 'emoji': '😰'},
      {'emotion': 'Sad', 'color': Colors.orange, 'emoji': '😞'},
      {'emotion': 'Neutral', 'color': Colors.yellow, 'emoji': '😐'},
      {'emotion': 'Excited', 'color': Colors.green, 'emoji': '😆'},
      {'emotion': 'Happy', 'color': Colors.blue, 'emoji': '😊'},
      {'emotion': 'Chill', 'color': Colors.purple, 'emoji': '😎'}
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
                  runSpacing: 4,
                  children: emotions.map((emotionData) {
                    return ChoiceChip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(emotionData['emoji'],
                              style: TextStyle(fontSize: 20)),
                          SizedBox(width: 4),
                          Text(emotionData['emotion']),
                        ],
                      ),
                      selected: selectedEmotion == emotionData['emotion'],
                      selectedColor: emotionData['color'],
                      onSelected: (selected) {
                        selectedEmotion =
                            selected ? emotionData['emotion'] : null;
                        (context as Element).markNeedsBuild();
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
                    (context as Element).markNeedsBuild();
                  },
                ),
                SizedBox(height: 16),
                TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: musicController,
                    decoration: InputDecoration(hintText: 'Enter music name'),
                  ),
                  suggestionsCallback: (pattern) async {
                    return await _spotifyService.searchTracks(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: suggestion['albumArt'] != null
                          ? Image.network(
                              suggestion['albumArt']!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : Icon(Icons.music_note),
                      title: Text(suggestion['name']!),
                      subtitle: Text(suggestion['artist']!),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    musicController.text =
                        '${suggestion['artist']} - ${suggestion['name']}';
                  },
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
                DateTime time = DateTime.now();
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
