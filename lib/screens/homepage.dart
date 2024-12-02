import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
