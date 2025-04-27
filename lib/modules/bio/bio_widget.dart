import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class BioWidget extends StatelessWidget {
  const BioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 90),
          Text("I'm a Software Developer", style: TextStyle(fontSize: 65, color: appColor(context)?.primaryText,fontFamily: 'Caveat')),
          Text(
            "Software Developer with hands-on experience in Flutter, Dart, and full-stack development using Next.js and Express.js. Passionate aboutbuilding scalable, high-performance applications and contributing toinnovative projects. Eager to leverage my skills in state management, API integration, and deployment to create impactful software solutions.",
            style: TextStyle(fontSize: 24, color: appColor(context)?.primaryText,fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
