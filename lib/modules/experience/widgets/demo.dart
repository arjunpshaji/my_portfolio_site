import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class GlowingContainer extends StatelessWidget {
  final Widget child;
  const GlowingContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback:
          (bounds) => RadialGradient(
            center: Alignment.center,
            radius: 0.6,
            colors: [appColor(context)!.secondaryText!, Colors.transparent],
            stops: [0.0, 1.0],
          ).createShader(bounds),
      blendMode: BlendMode.dst,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: appColor(context)!.secondaryText!.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [BoxShadow(color: appColor(context)!.secondaryText!.withValues(alpha: 0.6), blurRadius: 20, spreadRadius: 5)],
        ),
        child: child,
      ),
    );
  }
}
