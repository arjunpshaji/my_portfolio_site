import 'package:flutter/material.dart';
import 'package:my_portfolio/modules/hero/widgets/name_widget.dart';
import 'package:my_portfolio/modules/hero/widgets/profile_image_widget.dart';
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
              ProfileImageWidget(),
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
