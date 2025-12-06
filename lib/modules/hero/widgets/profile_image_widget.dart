import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final profileImage = context.select<PortfolioProvider, String?>(
      (p) => p.profile?.profileImage,
    );

    return ShaderMask(
      shaderCallback:
          (bounds) => RadialGradient(
            center: Alignment.center,
            radius: 0.6,
            colors: [
              appColor(context)!.secondaryText!.withValues(alpha: 0.015),
              Colors.transparent,
            ],
            stops: [0.0, 1.0],
          ).createShader(bounds),
      blendMode: BlendMode.dst,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: appColor(context)!.secondaryText!.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: appColor(context)!.secondaryText!.withValues(alpha: 0.30),
              blurRadius: 30,
              spreadRadius: 8,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child:
              profileImage != null && profileImage.isNotEmpty
                  ? Image.network(
                    profileImage,
                    fit: BoxFit.cover,
                    width: 400,
                    height: 400,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback to local asset if network image fails
                      return Image.asset(
                        "assets/images/mydp.png",
                        fit: BoxFit.cover,
                        width: 400,
                        height: 400,
                      );
                    },
                  )
                  : Image.asset(
                    "assets/images/mydp.png",
                    fit: BoxFit.cover,
                    width: 400,
                    height: 400,
                  ),
        ),
      ),
    );
  }
}
