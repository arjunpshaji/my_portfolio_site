import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback onTap;
  const ImageButton({super.key, required this.assetPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    return InkWell(onTap: onTap,child: Image.asset(assetPath, width: isMobile ? 45 : 70, height: isMobile ? 50 : 70));
  }
}
