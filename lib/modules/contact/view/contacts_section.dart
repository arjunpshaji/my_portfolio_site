import 'package:flutter/material.dart';
import 'package:my_portfolio/support/helper.dart';

import 'package:my_portfolio/theme/widgets/image_button.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';
import 'package:my_portfolio/models/social_links.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    final socialLinks = context.select<PortfolioProvider, List<SocialLink>>(
      (p) => p.socialLinks,
    );
    final email = context.select<PortfolioProvider, String>(
      (p) => p.profile?.email ?? 'imarjunpshaji@gmail.com',
    );

    return Column(
      spacing: 12,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children:
              socialLinks.map((link) {
                // Map label to icon asset
                String assetPath;
                final label = link.label.toLowerCase();
                if (label.contains('linkedin')) {
                  assetPath = "assets/icons/linkedin_icon.png";
                } else if (label.contains('github')) {
                  assetPath = "assets/icons/github_logo.png";
                } else if (label.contains('instagram')) {
                  assetPath = "assets/icons/instagram_icon.png";
                } else if (label.contains('gmail') || label.contains('email')) {
                  assetPath = "assets/icons/gmail_icon.png";
                } else {
                  return const SizedBox.shrink();
                }

                return ImageButton(
                  assetPath: assetPath,
                  onTap: () => launchAppUrl(link.url),
                );
              }).toList(),
        ),
      ],
    );
  }
}
