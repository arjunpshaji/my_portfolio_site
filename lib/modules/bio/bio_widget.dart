import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';

class BioWidget extends StatelessWidget {
  const BioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 90),
        Text("I'm a Software Developer", style: TextStyle(fontSize: 50, color: appColor(context)?.primaryText)),
        Text(
          "Software Developer with hands-on experience in Flutter, Dart, and full-stack development using Next.js and Express.js. Passionate aboutbuilding scalable, high-performance applications and contributing toinnovative projects. Eager to leverage my skills in state management, API integration, and deployment to create impactful software solutions.",
          style: TextStyle(fontSize: 24, color: appColor(context)?.primaryText),
        ),
      ],
    );
  }
}
