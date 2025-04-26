import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: const [
          Text('About Me', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Text(
            'I am a passionate Flutter developer with 3 years of experience in building beautiful apps for Android, iOS, and Web.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
