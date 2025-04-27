import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: appColor(context)?.secondaryText,
      child: Center(child: Text('© 2025 Arjun P Shaji. All rights reserved.', style: TextStyle(color: appColor(context)?.primaryText))),
    );
  }
}
