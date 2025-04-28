import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback:
          (bounds) => RadialGradient(
            center: Alignment.center,
            radius: 0.6,
            colors: [appColor(context)!.secondaryText!.withValues(alpha: 0.015), Colors.transparent],
            stops: [0.0, 1.0],
          ).createShader(bounds),
      blendMode: BlendMode.dst,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: appColor(context)!.secondaryText!.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [BoxShadow(color: appColor(context)!.secondaryText!.withValues(alpha: 0.30), blurRadius: 30, spreadRadius: 8)],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset("assets/images/mydp.png", fit: BoxFit.cover, width: 400, height: 400),
        ),
      ),
    );
  }
}
