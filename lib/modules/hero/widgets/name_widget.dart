import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class NameWidget extends StatelessWidget {
  const NameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = appColor(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 650;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Status Badge: Available for opportunities
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xff10B981).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xff10B981).withValues(alpha: 0.35),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff10B981),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff10B981),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Available for opportunities',
                style: TextStyle(
                  color: Color(0xff34D399),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Manrope',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Main Greeting with Gradient Name
        RichText(
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          text: TextSpan(
            style: TextStyle(
              fontSize: isMobile ? 32 : 52,
              fontWeight: FontWeight.w900,
              fontFamily: 'Manrope',
              letterSpacing: -1.2,
              height: 1.15,
            ),
            children: [
              TextSpan(
                text: "Hello, I'm\n",
                style: TextStyle(
                  color: colors.primaryText,
                  fontWeight: FontWeight.w800,
                ),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color(0xffC084FC),
                      Color(0xff38BDF8),
                      Color(0xffA855F7),
                    ],
                  ).createShader(bounds),
                  child: Text(
                    'Arjun P Shaji',
                    style: TextStyle(
                      fontSize: isMobile ? 36 : 56,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Manrope',
                      letterSpacing: -1.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
