import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class SkillTile extends StatelessWidget {
  final String assetPath;
  final String title;
  const SkillTile({super.key, required this.assetPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      padding: EdgeInsets.all(24),
      height: 130,
      alignment: Alignment.center,
      child: Image.asset(assetPath),
    );
  }
}
