import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback onTap;
  const ImageButton({super.key, required this.assetPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap,child: Image.asset(assetPath, width: 70, height: 70));
  }
}
