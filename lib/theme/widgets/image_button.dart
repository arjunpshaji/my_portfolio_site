import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/widgets/custom_cursor.dart';

class ImageButton extends StatefulWidget {
  final String assetPath;
  final VoidCallback onTap;
  final String? tooltip;

  const ImageButton({
    super.key,
    required this.assetPath,
    required this.onTap,
    this.tooltip,
  });

  @override
  State<ImageButton> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final size = isMobile ? 44.0 : 50.0;
    final iconSize = isMobile ? 22.0 : 26.0;

    Widget button = MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        CursorController.instance.setHovering(true);
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
          _isPressed = false;
        });
        CursorController.instance.setHovering(false);
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isPressed ? 0.94 : (_isHovered ? 1.12 : 1.0),
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    center: Alignment.topLeft,
                    radius: 1.0,
                    colors: _isHovered
                        ? [
                            const Color(0xffC084FC).withValues(alpha: 0.35),
                            const Color(0xff06B6D4).withValues(alpha: 0.25),
                            const Color(0xff16102E).withValues(alpha: 0.85),
                          ]
                        : [
                            Colors.white.withValues(alpha: 0.12),
                            const Color(0xff120E29).withValues(alpha: 0.65),
                            const Color(0xff0A071A).withValues(alpha: 0.8),
                          ],
                  ),
                  border: Border.all(
                    color: _isHovered
                        ? const Color(0xffC084FC).withValues(alpha: 0.8)
                        : Colors.white.withValues(alpha: 0.18),
                    width: _isHovered ? 1.5 : 1.0,
                  ),
                  boxShadow: [
                    if (_isHovered) ...[
                      BoxShadow(
                        color: const Color(0xffA855F7).withValues(alpha: 0.5),
                        blurRadius: 18,
                        spreadRadius: 2,
                      ),
                      BoxShadow(
                        color: const Color(0xff06B6D4).withValues(alpha: 0.35),
                        blurRadius: 24,
                        spreadRadius: 1,
                      ),
                    ] else
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Top Specular Highlight
                    Positioned(
                      top: 4,
                      child: Container(
                        width: size * 0.45,
                        height: 1.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1),
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.white.withValues(alpha: _isHovered ? 0.85 : 0.4),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        widget.assetPath,
                        width: iconSize,
                        height: iconSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (widget.tooltip != null) {
      return Tooltip(
        message: widget.tooltip!,
        child: button,
      );
    }
    return button;
  }
}
