import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final size = isMobile ? 42.0 : 48.0;
    final iconSize = isMobile ? 22.0 : 26.0;

    Widget button = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isHovered
                ? const Color(0xffA855F7).withValues(alpha: 0.25)
                : Colors.white.withValues(alpha: 0.06),
            border: Border.all(
              color: _isHovered
                  ? const Color(0xffC084FC)
                  : Colors.white.withValues(alpha: 0.15),
              width: _isHovered ? 1.5 : 1.0,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xffA855F7).withValues(alpha: 0.4),
                      blurRadius: 14,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Image.asset(
              widget.assetPath,
              width: iconSize,
              height: iconSize,
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
