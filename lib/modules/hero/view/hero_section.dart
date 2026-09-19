import 'package:flutter/material.dart';
import 'package:my_portfolio/modules/contact/view/contacts_section.dart';
import 'package:my_portfolio/support/helper.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';
import 'package:my_portfolio/modules/hero/widgets/name_widget.dart';
import 'package:my_portfolio/modules/hero/widgets/profile_image_widget.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onViewProjects;
  final VoidCallback? onContact;

  const HeroSection({
    super.key,
    this.onViewProjects,
    this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;

    final tagline = context.select<PortfolioProvider, String>(
      (p) => p.profile?.tagline ?? "Senior Flutter & Mobile Developer",
    );
    final cvUrl = context.select<PortfolioProvider, String?>(
      (p) => p.profile?.cvUrl,
    );

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 40.0,
        vertical: isMobile ? 30.0 : 70.0,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ProfileImageWidget(),
                const SizedBox(height: 36),
                const NameWidget(),
                const SizedBox(height: 16),
                _HeroTagline(tagline: tagline, isMobile: true),
                const SizedBox(height: 28),
                _CtaButtons(
                  isMobile: true,
                  cvUrl: cvUrl,
                  onViewProjects: onViewProjects,
                  onContact: onContact,
                ),
                const SizedBox(height: 32),
                const SocialLinksBar(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left Column: Text & Actions
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const NameWidget(),
                      const SizedBox(height: 20),
                      _HeroTagline(tagline: tagline, isMobile: false),
                      const SizedBox(height: 32),
                      _CtaButtons(
                        isMobile: false,
                        cvUrl: cvUrl,
                        onViewProjects: onViewProjects,
                        onContact: onContact,
                      ),
                      const SizedBox(height: 36),
                      const SocialLinksBar(),
                    ],
                  ),
                ),
                const SizedBox(width: 48),
                // Right Column: Avatar & Glow
                const Expanded(
                  flex: 5,
                  child: ProfileImageWidget(),
                ),
              ],
            ),
    );
  }
}

class _HeroTagline extends StatelessWidget {
  final String tagline;
  final bool isMobile;

  const _HeroTagline({required this.tagline, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final colors = appColor(context)!;
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          tagline,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: isMobile ? 20 : 26,
            fontWeight: FontWeight.w700,
            color: colors.secondaryText ?? const Color(0xffC084FC),
            fontFamily: 'Manrope',
          ),
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Text(
            "Architecting high-performance, responsive cross-platform apps with Clean Architecture, reactive state management (Riverpod/BLoC), and seamless cloud & IoT integrations.",
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: isMobile ? 15 : 17,
              height: 1.6,
              color: colors.subText ?? const Color(0xff94A3B8),
              fontFamily: 'Manrope',
            ),
          ),
        ),
      ],
    );
  }
}

class _CtaButtons extends StatelessWidget {
  final bool isMobile;
  final String? cvUrl;
  final VoidCallback? onViewProjects;
  final VoidCallback? onContact;

  const _CtaButtons({
    required this.isMobile,
    this.cvUrl,
    this.onViewProjects,
    this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 14,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: [
        // Primary Button: View Projects
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff7C3AED),
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            shadowColor: const Color(0xff7C3AED).withValues(alpha: 0.5),
          ),
          onPressed: onViewProjects,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                "Explore Projects",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Manrope',
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_downward_rounded, size: 16, color: Colors.white),
            ],
          ),
        ),

        // Secondary Button: Contact Me
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            side: BorderSide(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
          onPressed: onContact,
          child: const Text(
            "Get in Touch",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: 'Manrope',
            ),
          ),
        ),

        // Download CV Button
        if (cvUrl != null && cvUrl!.isNotEmpty)
          TextButton.icon(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            onPressed: () => launchAppUrl(cvUrl!),
            icon: const Icon(Icons.download_rounded, color: Color(0xff38BDF8), size: 18),
            label: const Text(
              "Download CV",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xff38BDF8),
                fontFamily: 'Manrope',
              ),
            ),
          ),
      ],
    );
  }
}
