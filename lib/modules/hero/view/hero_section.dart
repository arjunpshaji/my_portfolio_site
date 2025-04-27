import 'package:flutter/material.dart';
import 'package:my_portfolio/modules/experience/widgets/glowing_container.dart';
import 'package:my_portfolio/modules/hero/widgets/name_widget.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 60),
          NameWidget(),
          Row(
            spacing: 53,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback:
                    (bounds) => RadialGradient(
                      center: Alignment.center,
                      radius: 0.6,
                      colors: [appColor(context)!.secondaryText!.withValues(alpha: 0.015), Colors.transparent],
                      stops: [0.0, 1.0],
                    ).createShader(bounds),
                blendMode: BlendMode.dst,
                child: Container(
                  
                  // width: width ?? double.infinity,
                  // height: height,
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: appColor(context)!.secondaryText!.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [BoxShadow(color: appColor(context)!.secondaryText!.withValues(alpha: 0.30), blurRadius: 30, spreadRadius: 8)],
                  ),
                  child: ClipRRect(borderRadius: BorderRadius.circular(50),child: Image.asset("assets/images/mydp.jpg", fit: BoxFit.cover, width: 400, height: 400)),
                ),
              ),
              // GlowingContainer(
              //   padding: const EdgeInsets.all(16),
              //   width: 400,
              //   height: 400,
              //   borderRadius: BorderRadius.circular(200),
              //   child: ClipRRect(borderRadius: BorderRadius.circular(200), child: Image.asset("assets/images/mydp.jpg", fit: BoxFit.cover)),
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "A developer who",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: appColor(context)?.primaryText,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(fontSize: 50, color: appColor(context)?.primaryText),
                      children: [
                        TextSpan(text: "Judges a book\nby its ", style: TextStyle(color: appColor(context)?.primaryText)),
                        TextSpan(
                          text: "cover",
                          style: TextStyle(
                            color: appColor(context)?.secondaryText,
                            decoration: TextDecoration.underline,
                            decorationColor: appColor(context)?.secondaryText,
                            fontSize: 66,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Because if the cover does not impress you what else can?",
                    style: TextStyle(fontSize: 24, color: appColor(context)?.primaryText),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
