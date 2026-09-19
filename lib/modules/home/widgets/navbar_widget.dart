import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_portfolio/support/helper.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/theme/widgets/custom_cursor.dart';
import 'package:my_portfolio/theme/widgets/liquid_glass.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';

class NavbarWidget extends StatelessWidget {
  final Function(int) onSectionSelected;

  const NavbarWidget({super.key, required this.onSectionSelected});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    final cvUrl = context.select<PortfolioProvider, String?>(
      (p) => p.profile?.cvUrl,
    );

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 36,
          vertical: 16,
        ),
        constraints: const BoxConstraints(maxWidth: 1200),
        child: LiquidGlassContainer(
          borderRadius: 28,
          blur: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          tintColor: const Color(0xff8B5CF6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Brand / Logo with liquid hover effect
              _BrandLogo(onTap: () => onSectionSelected(0)),

              // Desktop Nav Links
              if (!isMobile)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _NavLink(title: 'About', onTap: () => onSectionSelected(1)),
                    _NavLink(title: 'Experience', onTap: () => onSectionSelected(2)),
                    _NavLink(title: 'Skills', onTap: () => onSectionSelected(3)),
                    _NavLink(title: 'Projects', onTap: () => onSectionSelected(4)),
                    _NavLink(title: 'Contact', onTap: () => onSectionSelected(5)),
                    const SizedBox(width: 14),
                    LiquidGlassButton(
                      label: 'Resume',
                      icon: Icons.download_rounded,
                      primaryColor: const Color(0xff8B5CF6),
                      secondaryColor: const Color(0xff06B6D4),
                      onTap: () {
                        if (cvUrl != null && cvUrl.isNotEmpty) {
                          launchAppUrl(cvUrl);
                        }
                      },
                    ),
                  ],
                )
              else
                // Mobile Hamburger Menu
                IconButton(
                  icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 28),
                  onPressed: () => _openMobileMenu(context, cvUrl),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _openMobileMenu(BuildContext context, String? cvUrl) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: BoxDecoration(
              color: const Color(0xff0F0C20).withValues(alpha: 0.95),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                _MobileSheetItem(
                  title: 'About Me',
                  icon: Icons.person_outline_rounded,
                  onTap: () {
                    Navigator.pop(ctx);
                    onSectionSelected(1);
                  },
                ),
                _MobileSheetItem(
                  title: 'Experience',
                  icon: Icons.work_outline_rounded,
                  onTap: () {
                    Navigator.pop(ctx);
                    onSectionSelected(2);
                  },
                ),
                _MobileSheetItem(
                  title: 'Skills & Toolkit',
                  icon: Icons.code_rounded,
                  onTap: () {
                    Navigator.pop(ctx);
                    onSectionSelected(3);
                  },
                ),
                _MobileSheetItem(
                  title: 'Featured Projects',
                  icon: Icons.dashboard_outlined,
                  onTap: () {
                    Navigator.pop(ctx);
                    onSectionSelected(4);
                  },
                ),
                _MobileSheetItem(
                  title: 'Contact',
                  icon: Icons.mail_outline_rounded,
                  onTap: () {
                    Navigator.pop(ctx);
                    onSectionSelected(5);
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: LiquidGlassButton(
                    label: 'Download CV',
                    icon: Icons.download_rounded,
                    primaryColor: const Color(0xff8B5CF6),
                    secondaryColor: const Color(0xff06B6D4),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    onTap: () {
                      Navigator.pop(ctx);
                      if (cvUrl != null && cvUrl.isNotEmpty) {
                        launchAppUrl(cvUrl);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BrandLogo extends StatefulWidget {
  final VoidCallback onTap;
  const _BrandLogo({required this.onTap});

  @override
  State<_BrandLogo> createState() => _BrandLogoState();
}

class _BrandLogoState extends State<_BrandLogo> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = appColor(context)!;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 180),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      colors.secondaryText ?? const Color(0xffA855F7),
                      colors.accentColor ?? const Color(0xff06B6D4),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffA855F7)
                          .withValues(alpha: _isHovered ? 0.6 : 0.25),
                      blurRadius: _isHovered ? 16 : 8,
                      spreadRadius: _isHovered ? 2 : 0,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'A',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      fontFamily: 'Manrope',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Arjun P Shaji',
                style: TextStyle(
                  color: _isHovered
                      ? const Color(0xff38BDF8)
                      : colors.primaryText,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Manrope',
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _NavLink({required this.title, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = appColor(context)!;
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        CursorController.instance.setHovering(true);
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        CursorController.instance.setHovering(false);
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _isHovered
                  ? Colors.white.withValues(alpha: 0.2)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              color: _isHovered
                  ? (colors.accentColor ?? const Color(0xff06B6D4))
                  : colors.primaryText?.withValues(alpha: 0.85),
              fontWeight: _isHovered ? FontWeight.bold : FontWeight.w500,
              fontSize: 14,
              fontFamily: 'Manrope',
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileSheetItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _MobileSheetItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = appColor(context)!;
    return ListTile(
      leading: Icon(icon, color: colors.secondaryText ?? const Color(0xffA855F7)),
      title: Text(
        title,
        style: TextStyle(
          color: colors.primaryText,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Manrope',
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
