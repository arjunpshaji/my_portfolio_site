import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final name = context.select<PortfolioProvider, String>(
      (p) => p.profile?.fullName ?? 'Arjun P Shaji',
    );
    final email = context.select<PortfolioProvider, String>(
      (p) => p.profile?.email ?? 'imarjunpshaji@gmail.com',
    );
    return Container(
      padding: const EdgeInsets.all(10),
      color: appColor(context)?.secondaryText?.withValues(alpha: 0.15),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     SelectableText(
      //       email,
      //       style: TextStyle(
      //         fontSize: isMobile ? 5 : 8,
      //         color: appColor(context)?.primaryText,
      //         fontStyle: FontStyle.italic,
      //       ),
      //     ),
      //     Text(
      //       '© ${DateTime.now().year} $name. All rights reserved.',
      //       style: TextStyle(
      //         fontSize: isMobile ? 5 : 8,
      //         color: appColor(context)?.primaryText,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
