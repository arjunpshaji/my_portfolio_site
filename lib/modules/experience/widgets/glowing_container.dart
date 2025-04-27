import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class GlowingContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  const GlowingContainer({super.key, required this.child, this.width, this.borderRadius, this.height, this.padding, this.border});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback:
          (bounds) => RadialGradient(
            center: Alignment.center,
            radius: 0.6,
            colors: [appColor(context)!.secondaryText!.withValues(alpha: 0.003), Colors.transparent],
            stops: [0.0, 1.0],
          ).createShader(bounds),
      blendMode: BlendMode.dst,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        padding: padding,
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: appColor(context)!.secondaryText!.withValues(alpha: 0.003),
          borderRadius: borderRadius ?? BorderRadius.circular(50),
          border:border,
          boxShadow: [BoxShadow(color: appColor(context)!.secondaryText!.withValues(alpha: 0.20), blurRadius: 20, spreadRadius: 5)],
        ),
        child: child,
      ),
    );
  }
}
