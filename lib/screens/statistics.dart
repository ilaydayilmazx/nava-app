import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import '../service/post_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final PostService _postService = PostService();
  Map<String, int> emotionCounts = {
    'Angry': 0,
    'Anxious': 0,
    'Sad': 0,
    'Neutral': 0,
    'Excited': 0,
    'Happy': 0,
    'Chill': 0,
  };

  Map<String, int> provinceEmotionCounts = {
    'Angry': 0,
    'Anxious': 0,
    'Sad': 0,
    'Neutral': 0,
    'Excited': 0,
    'Happy': 0,
    'Chill': 0,
  };

  String selectedProvince = '';

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  // Kullanıcının son bir haftalık postlarını al
  void _loadStatistics() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      List<Map<String, dynamic>> posts =
          await _postService.getUserPosts(user.uid);
      DateTime oneWeekAgo = DateTime.now().subtract(Duration(days: 7));

      // Son bir haftadaki postları filtrele
      for (var post in posts) {
        DateTime postTime = (post['time'] as Timestamp).toDate();
        if (postTime.isAfter(oneWeekAgo)) {
          String emotion = post['emotion'];
          setState(() {
            emotionCounts[emotion] = (emotionCounts[emotion] ?? 0) + 1;
          });
        }
      }
    }
  }

  // İlçe için duygu istatistiklerini yükle
  void _loadProvinceStatistics(String province) async {
    print("Loading statistics for province: $province"); // Debug mesajı
    List<Map<String, dynamic>> posts = await _postService.getAllPosts();
    print("Total posts fetched: ${posts.length}"); // Debug mesajı

    // İlçe istatistiklerini sıfırla
    setState(() {
      provinceEmotionCounts = {
        'Angry': 0,
        'Anxious': 0,
        'Sad': 0,
        'Neutral': 0,
        'Excited': 0,
        'Happy': 0,
        'Chill': 0,
      };
    });

    // İlçe için duygu istatistiklerini hesapla
    for (var post in posts) {
      String postProvince =
          post['province']?.toString() ?? ''; // province alanını al
      String emotion = post['emotion']?.toString() ?? ''; // emotion alanını al

      // Büyük-küçük harf duyarlılığını kaldır
      if (postProvince.toLowerCase() == province.toLowerCase()) {
        print(
            "Found post with emotion: $emotion in province: $postProvince"); // Debug mesajı
        setState(() {
          provinceEmotionCounts[emotion] =
              (provinceEmotionCounts[emotion] ?? 0) + 1;
        });
      }
    }

    print("Province emotion counts: $provinceEmotionCounts"); // Debug mesajı
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Mood This Week',
                style: TextStyle(
                  fontFamily: 'Sarina',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFb3001e),
                ),
              ),
              SizedBox(height: 20),
              AspectRatio(
                aspectRatio: 1.5,
                child: PieChart(
                  PieChartData(
                    sections: _buildPieChartSections(emotionCounts),
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Tune Istanbul This Week',
                style: TextStyle(
                  fontFamily: 'Sarina',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFb3001e),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildProvinceButton('Adalar'),
                    _buildProvinceButton('Arnavutkoy'),
                    _buildProvinceButton('Atasehir'),
                    _buildProvinceButton('Avcilar'),
                    _buildProvinceButton('Bagcilar'),
                    _buildProvinceButton('Bahcelievler'),
                    _buildProvinceButton('Bakirkoy'),
                    _buildProvinceButton('Basaksehir'),
                    _buildProvinceButton('Bayrampasa'),
                    _buildProvinceButton('Besiktas'),
                    _buildProvinceButton('Beykoz'),
                    _buildProvinceButton('Beylikduzu'),
                    _buildProvinceButton('Beyoglu'),
                    _buildProvinceButton('Buyukcekmece'),
                    _buildProvinceButton('Catalca'),
                    _buildProvinceButton('Cekmekoy'),
                    _buildProvinceButton('Esenler'),
                    _buildProvinceButton('Esenyurt'),
                    _buildProvinceButton('Eyup'),
                    _buildProvinceButton('Fatih'),
                    _buildProvinceButton('Gaziosmanpasa'),
                    _buildProvinceButton('Gungoren'),
                    _buildProvinceButton('Kadikoy'),
                    _buildProvinceButton('Kagithane'),
                    _buildProvinceButton('Kartal'),
                    _buildProvinceButton('Kucukcekmece'),
                    _buildProvinceButton('Maltepe'),
                    _buildProvinceButton('Pendik'),
                    _buildProvinceButton('Sancaktepe'),
                    _buildProvinceButton('Sariyer'),
                    _buildProvinceButton('Silivri'),
                    _buildProvinceButton('Sultanbeyli'),
                    _buildProvinceButton('Sultangazi'),
                    _buildProvinceButton('Sile'),
                    _buildProvinceButton('Sisli'),
                    _buildProvinceButton('Tuzla'),
                    _buildProvinceButton('Umraniye'),
                    _buildProvinceButton('Uskudar'),
                    _buildProvinceButton('Zeytinburnu'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              if (selectedProvince.isNotEmpty)
                AspectRatio(
                  aspectRatio: 1.5,
                  child: PieChart(
                    PieChartData(
                      sections: _buildPieChartSections(provinceEmotionCounts),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 0,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProvinceButton(String province) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedProvince = province;
          });
          _loadProvinceStatistics(province);
        },
        child: Text(province),
      ),
    );
  }

  // Pasta grafik için dilim oluşturma
  List<PieChartSectionData> _buildPieChartSections(Map<String, int> counts) {
    List<PieChartSectionData> sections = [];

    counts.forEach((emotion, count) {
      if (count > 0) {
        sections.add(
          PieChartSectionData(
            value: count.toDouble(),
            color: _getEmotionColor(emotion),
            title: '${emotion}: $count',
            radius: 50,
            titleStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      }
    });

    return sections;
  }

  // Her bir duygu için renk seçimi
  Color _getEmotionColor(String emotion) {
    switch (emotion) {
      case 'Angry':
        return Color.fromARGB(255, 160, 2, 26);
      case 'Anxious':
        return Colors.red;
      case 'Sad':
        return Colors.orange;
      case 'Neutral':
        return Colors.yellow;
      case 'Excited':
        return Colors.green;
      case 'Happy':
        return Colors.blue;
      case 'Chill':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
