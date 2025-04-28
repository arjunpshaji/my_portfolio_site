import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    return Container(
      padding: const EdgeInsets.all(8),
      color: appColor(context)?.secondaryText,
      child: Center(child: Text('© 2025 Arjun P Shaji. All rights reserved.', style: TextStyle(fontSize: isMobile ? 10 : 14, color: appColor(context)?.primaryText))),
    );
  }
}
