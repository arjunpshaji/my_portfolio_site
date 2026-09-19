import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';

class ProfileImageWidget extends StatefulWidget {
  const ProfileImageWidget({super.key});

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 650;
    final imageSize = isMobile ? 260.0 : 340.0;

    final profileImage = context.select<PortfolioProvider, String?>(
      (p) => p.profile?.profileImage,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Center(
        child: SizedBox(
          width: imageSize + 60,
          height: imageSize + 60,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Ambient Glow Ring
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: imageSize + (_isHovered ? 40 : 20),
                height: imageSize + (_isHovered ? 40 : 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xffA855F7).withValues(alpha: _isHovered ? 0.45 : 0.25),
                      const Color(0xff06B6D4).withValues(alpha: _isHovered ? 0.25 : 0.10),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.65, 1.0],
                  ),
                ),
              ),

              // Rotating / Gradient Border Ring
              Container(
                width: imageSize + 12,
                height: imageSize + 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xffC084FC),
                      Color(0xff06B6D4),
                      Color(0xff7C3AED),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffA855F7).withValues(alpha: 0.3),
                      blurRadius: 24,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(4),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff0F0C20),
                  ),
                  child: ClipOval(
                    child: profileImage != null &&
                            profileImage.isNotEmpty &&
                            !profileImage.startsWith('assets/')
                        ? Image.network(
                            profileImage,
                            fit: BoxFit.cover,
                            width: imageSize,
                            height: imageSize,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              'assets/images/mydp.png',
                              fit: BoxFit.cover,
                              width: imageSize,
                              height: imageSize,
                            ),
                          )
                        : Image.asset(
                            'assets/images/mydp.png',
                            fit: BoxFit.cover,
                            width: imageSize,
                            height: imageSize,
                          ),
                  ),
                ),
              ),

              // Floating Chip - "React Native" (Top Left)
              Positioned(
                top: 25,
                left: 5,
                child: _FloatingBadge(
                  iconWidget: const CustomPaint(
                    size: Size(18, 18),
                    painter: _ReactLogoPainter(),
                  ),
                  label: 'React Native',
                  glowColor: const Color(0xff61DAFB),
                ),
              ),

              // Floating Chip - "Flutter" (Top Right)
              Positioned(
                top: 25,
                right: 5,
                child: _FloatingBadge(
                  icon: 'assets/icons/flutter_logo.png',
                  label: 'Flutter',
                  glowColor: const Color(0xff02569B),
                ),
              ),

              // Floating Chip - "Dart" (Bottom Left)
              Positioned(
                bottom: 25,
                left: 15,
                child: _FloatingBadge(
                  icon: 'assets/icons/dart_logo.png',
                  label: 'Dart',
                  glowColor: const Color(0xff0175C2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FloatingBadge extends StatelessWidget {
  final String? icon;
  final Widget? iconWidget;
  final String label;
  final Color glowColor;

  const _FloatingBadge({
    this.icon,
    this.iconWidget,
    required this.label,
    required this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xff16122B).withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: glowColor.withValues(alpha: 0.35),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconWidget != null)
            iconWidget!
          else if (icon != null)
            Image.asset(icon!, width: 18, height: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'Manrope',
            ),
          ),
        ],
      ),
    );
  }
}

class _ReactLogoPainter extends CustomPainter {
  const _ReactLogoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const color = Color(0xff61DAFB);
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    final nucleusPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Center nucleus
    canvas.drawCircle(center, size.width * 0.14, nucleusPaint);

    final rect = Rect.fromCenter(
      center: Offset.zero,
      width: size.width * 0.95,
      height: size.height * 0.36,
    );

    // 3 orbital rings rotated 60 deg apart
    for (int i = 0; i < 3; i++) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate((i * 60) * 3.1415926535 / 180);
      canvas.drawOval(rect, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
