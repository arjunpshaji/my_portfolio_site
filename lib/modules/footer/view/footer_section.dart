import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';

class FooterSection extends StatelessWidget {
  final VoidCallback? onBackToTop;

  const FooterSection({super.key, this.onBackToTop});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 700;
    final colors = appColor(context)!;
    final name = context.select<PortfolioProvider, String>(
      (p) => p.profile?.fullName ?? 'Arjun P Shaji',
    );

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xff080612),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 48.0,
        vertical: 36,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Top Row: Logo + Back to top
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xffA855F7), Color(0xff06B6D4)],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'A',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Manrope',
                        ),
                      ),
                    ],
                  ),

                  // Back to Top Button
                  if (onBackToTop != null)
                    InkWell(
                      onTap: onBackToTop,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              "Back to top",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Manrope',
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_upward_rounded, size: 16, color: Colors.white70),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),

              // Bottom Row: Copyright + Built With
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16,
                runSpacing: 8,
                children: [
                  Text(
                    '© ${DateTime.now().year} $name. All rights reserved.',
                    style: TextStyle(
                      fontSize: 13,
                      color: colors.subText,
                      fontFamily: 'Manrope',
                    ),
                  ),
                  Text(
                    'Designed & Engineered with Flutter & Dart ⚡',
                    style: TextStyle(
                      fontSize: 13,
                      color: colors.subText,
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
