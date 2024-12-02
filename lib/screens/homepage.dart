import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
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
    );
  }
}
