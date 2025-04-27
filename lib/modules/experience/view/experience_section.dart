import 'package:flutter/material.dart';
import 'package:my_portfolio/modules/experience/widgets/demo.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text("Experience", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700, color: appColor(context)?.primaryText)),
        ),
        GlowingContainer(
          child: Text(
            "Developed and deployed over 5 mobile applications for Android and iOS using Flutter and Dart, achieving 95% crash-free sessions while implementing state management with Riverpod and Cubit to reduce widget rebuilds by 30% and improve app performance by 20%; designed and integrated RESTful and GraphQL APIs to enhance data fetching efficiency by 40% and achieve real-time updates with under 200ms response time; streamlined API development using Swagger, Apollo GraphQL, Postman, and Telescope, reducing debugging time by 30%; led a team of 4 developers in agile sprints, ensuring timely delivery of milestones and maintaining high code quality through regular code reviews; and successfully deployed applications to the Google Play Store while assisting with iOS App Store deployment.",
            style: TextStyle(fontSize: 16, color: appColor(context)?.primaryText),
          ),
        ),
      ],
    );
  }
}
