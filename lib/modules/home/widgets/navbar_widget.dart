import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_portfolio/support/helper.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';

class NavbarWidget extends StatelessWidget {
  final Function(int) onSectionSelected;

  const NavbarWidget({super.key, required this.onSectionSelected});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    final colors = appColor(context)!;
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xff0B0819).withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.12),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Brand / Logo
                  InkWell(
                    onTap: () => onSectionSelected(0), // Hero / Top
                    borderRadius: BorderRadius.circular(12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                colors.secondaryText ?? const Color(0xffA855F7),
                                colors.accentColor ?? const Color(0xff06B6D4),
                              ],
                            ),
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
                            color: colors.primaryText,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'Manrope',
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),

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
                        const SizedBox(width: 16),
                        _ResumeButton(
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
        ),
      ),
    );
  }

  void _openMobileMenu(BuildContext context, String? cvUrl) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final colors = appColor(context)!;
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
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
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.secondaryText ?? const Color(0xffA855F7),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(Icons.download_rounded, color: Colors.white),
                    label: const Text(
                      'Download CV',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
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
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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

class _ResumeButton extends StatefulWidget {
  final VoidCallback onTap;

  const _ResumeButton({required this.onTap});

  @override
  State<_ResumeButton> createState() => _ResumeButtonState();
}

class _ResumeButtonState extends State<_ResumeButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isHovered
                  ? [
                      const Color(0xff9333EA),
                      const Color(0xff06B6D4),
                    ]
                  : [
                      const Color(0xff7C3AED),
                      const Color(0xffA855F7),
                    ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xffA855F7).withValues(alpha: 0.45),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.download_rounded, color: Colors.white, size: 16),
              SizedBox(width: 8),
              Text(
                'Resume',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  fontFamily: 'Manrope',
                ),
              ),
            ],
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
