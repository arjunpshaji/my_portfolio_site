import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';
import 'package:my_portfolio/models/profile.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final name = context.select<PortfolioProvider, String>(
      (p) => p.profile?.fullName ?? 'Arjun P Shaji',
    );
    return Container(
      padding: const EdgeInsets.all(8),
      color: appColor(context)?.secondaryText,
      child: Center(
        child: Text(
          '© ${DateTime.now().year} $name. All rights reserved.',
          style: TextStyle(
            fontSize: isMobile ? 10 : 14,
            color: appColor(context)?.primaryText,
          ),
        ),
      ),
    );
  }
}
