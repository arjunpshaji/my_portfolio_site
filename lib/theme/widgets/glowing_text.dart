import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class GlowingText extends StatefulWidget {
  final bool isMobile;
  final String text;

  const GlowingText({super.key, required this.isMobile, required this.text});

  @override
  State<GlowingText> createState() => _GlowingTextState();
}

class _GlowingTextState extends State<GlowingText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true); // repeat forward and backward (blinking)

    _colorAnimation = ColorTween(
      begin: Color(0xff7127BA).withValues(alpha:0.3),
      end: Color.fromARGB(255, 180, 134, 225),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final secondaryColor = appColor(context)?.secondaryText ?? Colors.white;

    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Text(
          widget.text,
          style: TextStyle(
            fontSize: widget.isMobile ? 18 : 24,
            color: _colorAnimation.value,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w700,
            shadows: [
              Shadow(
                blurRadius: 12,
                color: _colorAnimation.value ?? secondaryColor,
                offset: const Offset(0, 0),
              ),
            ],
          ),
        );
      },
    );
  }
}