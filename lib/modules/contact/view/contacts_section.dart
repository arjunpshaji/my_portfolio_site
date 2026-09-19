import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_portfolio/support/helper.dart';
import 'package:my_portfolio/theme/widgets/image_button.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';
import 'package:my_portfolio/models/social_links.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/theme/widgets/liquid_glass.dart';

class SocialLinksBar extends StatelessWidget {
  const SocialLinksBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    final socialLinks = context.select<PortfolioProvider, List<SocialLink>>(
      (p) => p.socialLinks,
    );

    return Wrap(
      spacing: 14,
      runSpacing: 12,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: socialLinks.map((link) {
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
          tooltip: link.label,
          onTap: () => launchAppUrl(link.url),
        );
      }).toList(),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    final colors = appColor(context)!;
    final email = context.select<PortfolioProvider, String>(
      (p) => p.profile?.email ?? 'imarjunpshaji@gmail.com',
    );
    final location = context.select<PortfolioProvider, String?>(
      (p) => p.profile?.location ?? 'Kerala, India',
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 64.0,
        vertical: 80,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1100),
          padding: EdgeInsets.all(isMobile ? 28 : 56),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xff16122E).withValues(alpha: 0.9),
                const Color(0xff0F0C20).withValues(alpha: 0.95),
              ],
            ),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.12),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xffA855F7).withValues(alpha: 0.15),
                blurRadius: 36,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              // Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xffA855F7).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xffA855F7).withValues(alpha: 0.35),
                  ),
                ),
                child: const Text(
                  'GET IN TOUCH',
                  style: TextStyle(
                    color: Color(0xffC084FC),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Manrope',
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                "Let's Build Something Extraordinary Together",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 30 : 46,
                  fontWeight: FontWeight.w900,
                  color: colors.primaryText,
                  fontFamily: 'Manrope',
                  letterSpacing: -1.0,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),

              // Description
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 650),
                child: Text(
                  "Have an exciting project, a role opening, or want to discuss mobile app architecture? Feel free to reach out directly.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 15 : 18,
                    color: colors.subText,
                    height: 1.6,
                    fontFamily: 'Manrope',
                  ),
                ),
              ),
              const SizedBox(height: 36),

              // Direct Email Button Card
              _EmailCard(email: email, isMobile: isMobile),
              const SizedBox(height: 32),

              // Social Links Bar
              const SocialLinksBar(),
              const SizedBox(height: 24),

              // Location chip
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: colors.accentColor ?? const Color(0xff06B6D4),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "$location • Open to Worldwide Remote",
                    style: TextStyle(
                      color: colors.subText,
                      fontSize: 13,
                      fontFamily: 'Manrope',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailCard extends StatefulWidget {
  final String email;
  final bool isMobile;

  const _EmailCard({required this.email, required this.isMobile});

  @override
  State<_EmailCard> createState() => _EmailCardState();
}

class _EmailCardState extends State<_EmailCard> {
  bool _isCopied = false;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassContainer(
      borderRadius: 20,
      blur: 20,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      tintColor: const Color(0xffA855F7),
      child: Wrap(
        spacing: 12,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.mail_outline_rounded, color: Color(0xffC084FC), size: 20),
              const SizedBox(width: 10),
              SelectableText(
                widget.email,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Manrope',
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Copy Button
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: widget.email));
                  setState(() => _isCopied = true);
                  Future.delayed(const Duration(seconds: 2), () {
                    if (mounted) setState(() => _isCopied = false);
                  });
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _isCopied
                          ? Colors.greenAccent.withValues(alpha: 0.5)
                          : Colors.white.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _isCopied ? Icons.check_rounded : Icons.copy_rounded,
                        size: 14,
                        color: _isCopied ? Colors.greenAccent : Colors.white70,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _isCopied ? "Copied!" : "Copy",
                        style: TextStyle(
                          fontSize: 12,
                          color: _isCopied ? Colors.greenAccent : Colors.white70,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Send Mail Button (Liquid Glass)
              LiquidGlassButton(
                label: "Say Hello",
                icon: Icons.send_rounded,
                primaryColor: const Color(0xff8B5CF6),
                secondaryColor: const Color(0xff06B6D4),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                borderRadius: 10,
                onTap: () => launchAppUrl("mailto:${widget.email}"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
