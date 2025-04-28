import 'package:flutter/material.dart';

class SkillTile extends StatelessWidget {
  final String assetPath;
  final String title;
  const SkillTile({super.key, required this.assetPath, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    return Container(
      margin: EdgeInsets.only(right: 16),
      padding: EdgeInsets.all(24),
      height: isMobile ? 110 : 130,
      alignment: Alignment.center,
      child: Image.asset(assetPath, width: isMobile ? 55 : 70, height: isMobile ? 55 : 70),
    );
  }
}
