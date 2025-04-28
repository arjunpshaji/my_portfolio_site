import 'package:flutter/material.dart';
import 'package:my_portfolio/modules/hero/widgets/name_widget.dart';
import 'package:my_portfolio/modules/hero/widgets/profile_image_widget.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          const NameWidget(),
          const SizedBox(height: 40),
          Wrap(
            spacing: 40,
            runSpacing: 32,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [const ProfileImageWidget(), _TextSection(isMobile: isMobile)],
          ),
        ],
      ),
    );
  }
}

class _TextSection extends StatelessWidget {
  final bool isMobile;

  const _TextSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final primaryColor = appColor(context)?.primaryText;
    final secondaryColor = appColor(context)?.secondaryText;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            "A developer who",
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(fontSize: isMobile ? 20 : 24, fontWeight: FontWeight.w700, color: primaryColor, decoration: TextDecoration.underline),
          ),
          const SizedBox(height: 16),
          Text.rich(
            TextSpan(
              style: TextStyle(fontSize: isMobile ? 36 : 50, color: primaryColor),
              children: [
                TextSpan(text: "Judges a book\nby its ", style: TextStyle(color: primaryColor)),
                TextSpan(
                  text: "cover",
                  style: TextStyle(
                    color: secondaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: secondaryColor,
                    fontSize: isMobile ? 44 : 66,
                  ),
                ),
              ],
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
          ),
          const SizedBox(height: 16),
          Text(
            "Because if the cover does not impress you what else can?",
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(fontSize: isMobile ? 20 : 24, color: primaryColor),
          ),
        ],
      ),
    );
  }
}
