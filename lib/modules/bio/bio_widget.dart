import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lottie/lottie.dart';
import 'package:my_portfolio/support/helper.dart';
import 'package:my_portfolio/theme/app_colors.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/theme/widgets/glowing_text.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';
import 'package:my_portfolio/models/profile.dart';

class BioWidget extends StatelessWidget {
  const BioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    final about = context.select<PortfolioProvider, String>(
      (p) =>
          p.profile?.about ?? "Software Developer with hands-on experience...",
    );
    final cvUrl = context.select<PortfolioProvider, String?>(
      (p) => p.profile?.cvUrl,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 90),
          Text(
            "I'm a Software Developer",
            style: TextStyle(
              fontSize: isMobile ? 55 : 65,
              color: appColor(context)?.primaryText,
              fontFamily: 'Caveat',
            ),
          ),
          Text(
            about,
            style: TextStyle(
              fontSize: isMobile ? 18 : 24,
              color: appColor(context)?.primaryText,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 12),
          ListTile(
            leading: Icon(
              Icons.cloud_download_outlined,
              color: appColor(context)?.primaryText,
              size: 24,
            ),
            title: GlowingText(isMobile: isMobile, text: "Download my CV"),
            onTap: () {
              if (cvUrl != null && cvUrl.isNotEmpty) {
                launchAppUrl(cvUrl);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("CV not available")),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
