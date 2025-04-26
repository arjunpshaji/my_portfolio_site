import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.indigo,
      child: const Center(child: Text('© 2025 John Doe. All rights reserved.', style: TextStyle(color: Colors.white))),
    );
  }
}
