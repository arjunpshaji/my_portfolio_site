import 'package:flutter/material.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      color: Colors.indigo.shade50,
      child: Column(
        children: [
          const Text('Contact Me', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const Text('Email: johndoe@example.com'),
          const SizedBox(height: 10),
          const Text('Phone: +91 9876543210'),
        ],
      ),
    );
  }
}
