import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class ContainerboxWidget extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  const ContainerboxWidget({super.key, required this.child, this.width, this.borderRadius, this.height, this.padding});

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
          border: Border.all(color: appColor(context)!.secondaryText!),
          color: appColor(context)!.secondaryText!.withValues(alpha: 0.003),
          borderRadius: borderRadius ?? BorderRadius.circular(50),
          boxShadow: [BoxShadow(color: appColor(context)!.secondaryText!.withValues(alpha: 0.50), blurRadius: 20, spreadRadius: 5)],
        ),
        child: child,
      ),
    );
  }
}
